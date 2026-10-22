import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../content/contact.dart';
import '../../content/identity.dart';
import '../../content/microcopy.dart';
import '../../content/models.dart';
import '../../core/motion/reveal.dart';
import '../../core/motion/springs.dart';
import '../../core/responsive/breakpoints.dart';
import '../../core/shapes/m3e_shapes.dart';
import '../../core/shapes/morph_loader.dart';
import '../../core/theme/tokens.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/copy_action.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/wavy_progress.dart';

/// Opens the visitor's mail app with the message. Swappable (tests, or a
/// form service later) without touching the sheet.
typedef MessageSender = Future<bool> Function(Uri mailto);

Future<bool> _launchMail(Uri mailto) => launchUrl(mailto);

/// The 3-step contact form in a modal bottom sheet: Name → Email →
/// Message, a wavy progress bar, and a success state. Fields are kept
/// until the visitor chooses "Write another".
class ContactSheet extends StatefulWidget {
  const ContactSheet({super.key, this.send = _launchMail});

  final MessageSender send;

  static Future<void> show(BuildContext context, {MessageSender send = _launchMail}) {
    final w = MediaQuery.sizeOf(context).width;
    final r = Radius.circular(Space.fluid(w, 28, 4, 48));
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: const BoxConstraints(maxWidth: 960),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      barrierColor: Colors.black.withValues(alpha: .5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: r, topRight: r),
      ),
      builder: (_) => ContactSheet(send: send),
    );
  }

  @override
  State<ContactSheet> createState() => _ContactSheetState();
}

class _ContactSheetState extends State<ContactSheet> {
  final Map<ContactField, TextEditingController> _text = {
    for (final f in ContactField.values) f: TextEditingController(),
  };
  final Map<ContactField, String?> _errors = {};
  final Set<ContactField> _touched = {};
  final FocusNode _focus = FocusNode();
  int _step = 0;
  bool _sending = false;
  bool _sent = false;
  String? _failure;

  ContactField get _field => ContactCopy.fields[_step].field;
  String _value(ContactField f) => _text[f]!.text;
  bool _valid(ContactField f) => ContactCopy.validate(f, _value(f)) == null;

  @override
  void dispose() {
    for (final c in _text.values) {
      c.dispose();
    }
    _focus.dispose();
    super.dispose();
  }

  void _onChanged(String v) {
    setState(() {
      _failure = null;
      _errors[_field] = _touched.contains(_field) ? ContactCopy.validate(_field, v) : null;
    });
  }

  void _goTo(int i) {
    for (var j = 0; j < i; j++) {
      final f = ContactCopy.fields[j].field;
      final e = ContactCopy.validate(f, _value(f));
      if (e != null) {
        setState(() {
          _step = j;
          _touched.add(f);
          _errors[f] = e;
        });
        _focus.requestFocus();
        return;
      }
    }
    setState(() => _step = i);
    _focus.requestFocus();
  }

  Future<void> _submit() async {
    final f = _field;
    final e = ContactCopy.validate(f, _value(f));
    if (e != null) {
      setState(() {
        _touched.add(f);
        _errors[f] = e;
      });
      return;
    }
    if (_step < 2) {
      _goTo(_step + 1);
      return;
    }
    setState(() {
      _sending = true;
      _failure = null;
    });
    final uri = ContactCopy.mailto(
      name: _value(ContactField.name).trim(),
      email: _value(ContactField.email).trim(),
      message: _value(ContactField.message).trim(),
    );
    String? failure;
    try {
      final ok = await widget.send(uri);
      if (!ok) failure = ContactCopy.errorNoMailApp;
    } catch (err) {
      failure = ContactCopy.errorOther(err);
    }
    if (!mounted) return;
    setState(() {
      _sending = false;
      _sent = failure == null;
      _failure = failure;
    });
  }

  void _reset() {
    for (final c in _text.values) {
      c.clear();
    }
    setState(() {
      _errors.clear();
      _touched.clear();
      _step = 0;
      _sent = false;
      _failure = null;
    });
  }

  double? get _progress {
    if (_sending) return null;
    if (_sent) return 1;
    return (_step + (_valid(_field) ? 1 : 0)) / 3;
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    final h = MediaQuery.sizeOf(context).height;
    final scheme = Theme.of(context).colorScheme;
    final insets = MediaQuery.viewInsetsOf(context).bottom;
    final fast = M3Spring.fastSpatial;

    final header = Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          "Let's work together",
          style: AppText.urbanist(Space.fluid(w, 24, 3, 34), 800, tracking: -.03).copyWith(color: scheme.onSurface),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(bottom: insets),
      child: SizedBox(
        height: (h * .92).clamp(0, 640),
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          label: Microcopy.contact,
          explicitChildNodes: true,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Space.fluid(w, 18, 5, 64),
              12,
              Space.fluid(w, 18, 5, 64),
              Space.fluid(w, 20, 4, 44),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(color: scheme.onSurfaceVariant, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                SizedBox(height: Space.fluid(w, 14, 2, 24)),
                Row(
                  children: [
                    Flexible(child: header),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 60),
                        child: WavyProgress(
                          value: _progress,
                          activeColor: scheme.primary,
                          trackColor: scheme.secondaryContainer,
                          semanticLabel: 'Form progress',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Pressable(
                      onTap: () => Navigator.of(context).maybePop(),
                      semanticLabel: 'Close',
                      tooltip: 'Close',
                      focusRadius: BorderRadius.circular(22),
                      builder: (context, s) => AnimatedContainer(
                        duration: fast.durationOf(context),
                        curve: fast.curve,
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(s.pressed ? 12 : 22),
                        ),
                        child: Icon(Icons.close_rounded, size: 22, color: scheme.onSurface),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Space.fluid(w, 14, 2, 24)),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (var i = 0; i < ContactCopy.fields.length; i++) _stepChip(context, i),
                    CopyAction(
                      text: Identity.email,
                      semanticLabel: 'Copy email ${Identity.email}',
                      focusRadius: BorderRadius.circular(12),
                      builder: (context, s, copied) => AnimatedContainer(
                        duration: fast.durationOf(context),
                        curve: fast.curve,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(s.hovered ? 20 : 12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.content_copy_rounded, size: 18, color: scheme.onSurface),
                            const SizedBox(width: 6),
                            Text(
                              copied ? Microcopy.copied : Identity.email,
                              style: AppText.manrope(13, 600).copyWith(color: scheme.onSurface),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Space.fluid(w, 14, 2, 24)),
                Expanded(child: _sent ? _success(context) : _form(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepChip(BuildContext context, int i) {
    final scheme = Theme.of(context).colorScheme;
    final f = ContactCopy.fields[i];
    final current = i == _step && !_sent;
    final done = _valid(f.field);
    final bg = current ? scheme.primary : (done ? scheme.secondaryContainer : scheme.surfaceContainerHighest);
    final fg = current ? scheme.onPrimary : (done ? scheme.onSecondaryContainer : scheme.onSurface);
    return Pressable(
      onTap: _sent ? null : () => _goTo(i),
      selected: current,
      semanticLabel: 'Step ${i + 1}: ${f.label}${done ? ', done' : ''}',
      focusRadius: BorderRadius.circular(20),
      builder: (context, s) => AnimatedContainer(
        duration: M3Spring.defaultEffects.durationOf(context),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Center(
          widthFactor: 1,
          child: Text('${i + 1} ${f.label}', style: AppText.manrope(14, 700).copyWith(color: fg)),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    final w = context.screenWidth;
    final scheme = Theme.of(context).colorScheme;
    final copy = ContactCopy.fields[_step];
    final isMsg = copy.field == ContactField.message;
    final err = _touched.contains(copy.field) ? _errors[copy.field] : null;
    final line = err != null ? scheme.error : scheme.primary;
    final inputStyle = isMsg
        ? AppText.urbanist(Space.fluid(w, 28, 4.4, 52), 300, height: 1.15, tracking: -.03)
        : AppText.urbanist(Space.fluid(w, 40, 7, 88), 200, height: 1, tracking: -.04);
    final fast = M3Spring.fastSpatial;

    return SingleChildScrollView(
      child: SwapReveal(
        keyValue: 'step$_step',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              err == null ? copy.label : '${copy.label} · $err',
              style: AppText.urbanist(16, 600).copyWith(color: err != null ? scheme.error : scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            Focus(
              onFocusChange: (has) {
                if (has) return;
                setState(() {
                  final f = copy.field;
                  if (_value(f).isNotEmpty) {
                    _touched.add(f);
                    _errors[f] = ContactCopy.validate(f, _value(f));
                  }
                });
              },
              child: CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.enter, meta: true): _submit,
                  const SingleActivator(LogicalKeyboardKey.enter, control: true): _submit,
                },
                child: TextField(
                  key: ValueKey(copy.field),
                  controller: _text[copy.field],
                  focusNode: _focus,
                  autofocus: true,
                  enabled: !_sending,
                  onChanged: _onChanged,
                  onSubmitted: isMsg ? null : (_) => _submit(),
                  keyboardType: switch (copy.field) {
                    ContactField.email => TextInputType.emailAddress,
                    ContactField.name => TextInputType.name,
                    ContactField.message => TextInputType.multiline,
                  },
                  textInputAction: isMsg ? TextInputAction.newline : TextInputAction.next,
                  autofillHints: switch (copy.field) {
                    ContactField.email => const [AutofillHints.email],
                    ContactField.name => const [AutofillHints.name],
                    ContactField.message => null,
                  },
                  minLines: isMsg ? 3 : 1,
                  maxLines: isMsg ? 3 : 1,
                  cursorColor: scheme.primary,
                  style: inputStyle.copyWith(color: scheme.onSurface),
                  decoration: InputDecoration(
                    hintText: copy.placeholder,
                    hintStyle: inputStyle.copyWith(color: scheme.onSurfaceVariant.withValues(alpha: .6)),
                    contentPadding: const EdgeInsets.only(top: 6, bottom: 12),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: line, width: 3)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: line, width: 3)),
                    disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: line, width: 3)),
                    semanticCounterText: '',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 20),
              child: Semantics(
                liveRegion: true,
                child: Text(_failure ?? err ?? '', style: AppText.urbanist(14, 600).copyWith(color: scheme.error)),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                Text(
                  ContactCopy.responseTime,
                  style: AppText.urbanist(15, 500).copyWith(color: scheme.onSurfaceVariant),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_step > 0)
                      Pressable(
                        onTap: _sending ? null : () => setState(() => _step--),
                        focusRadius: BorderRadius.circular(20),
                        builder: (context, s) => AnimatedContainer(
                          duration: fast.durationOf(context),
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: s.hovered ? scheme.surfaceContainerHighest : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Back', style: AppText.urbanist(17, 700).copyWith(color: scheme.primary)),
                        ),
                      ),
                    const SizedBox(width: 8),
                    _SubmitButton(
                      sending: _sending,
                      last: _step == 2,
                      onTap: _sending ? null : _submit,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _success(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        child: SwapReveal(
          keyValue: 'sent',
          child: Semantics(
            liveRegion: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShapeBox(
                  shape: M3Shape.sunny,
                  size: 120,
                  color: scheme.primary,
                  child: Icon(Icons.check_rounded, size: 56, color: scheme.onPrimary),
                ),
                const SizedBox(height: 16),
                Text(
                  ContactCopy.successTitle,
                  style: AppText.urbanist(40, 800, tracking: -.03).copyWith(color: scheme.onSurface),
                ),
                const SizedBox(height: 16),
                Text(
                  ContactCopy.successBody,
                  textAlign: TextAlign.center,
                  style: AppText.urbanist(18, 500, height: 1.5).copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                Pressable(
                  onTap: _reset,
                  autofocus: true,
                  focusRadius: BorderRadius.circular(16),
                  builder: (context, s) => Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      widthFactor: 1,
                      child: Text('Write another', style: AppText.urbanist(15, 700).copyWith(color: scheme.onSurface)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.sending, required this.last, required this.onTap});

  final bool sending;
  final bool last;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fast = M3Spring.fastSpatial;
    final label = sending ? ContactCopy.sending : (last ? ContactCopy.send : 'Next');
    return Pressable(
      onTap: onTap,
      enabled: onTap != null || sending,
      semanticLabel: label,
      focusRadius: BorderRadius.circular(20),
      builder: (context, s) => AnimatedContainer(
        duration: fast.durationOf(context),
        curve: fast.curve,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(s.pressed ? 12 : (sending ? 30 : 20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (sending)
              MorphLoader(
                shapes: const [M3Shape.cookie7, M3Shape.cookie9, M3Shape.clover4, M3Shape.sunny],
                size: 26,
                color: scheme.onPrimary,
              )
            else
              Icon(last ? Icons.send_rounded : Icons.arrow_forward_rounded, size: 22, color: scheme.onPrimary),
            const SizedBox(width: 10),
            Text(label, style: AppText.urbanist(17, 700).copyWith(color: scheme.onPrimary)),
          ],
        ),
      ),
    );
  }
}
