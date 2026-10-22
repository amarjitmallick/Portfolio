/// Switches for every copy item marked `VERIFY` in NEW_SITE_CONTENT_v4.md.
///
/// v4 rule: anything marked `VERIFY` is not final and must not render, so
/// every count or wording still waiting on the owner is off. Each flag is
/// listed in docs/BUILD_NOTES.md for the owner to confirm.
abstract final class Verify {
  /// §12.1: name the current employer in Career and project meta.
  /// Off → the descriptor below is shown instead.
  static const bool showEmployerName = true;
  static const String employerFallback = 'a B2B software company';

  /// §2 / §12.4: "20+ production and TestFlight releases" (hero release
  /// notes and the current role's first bullet).
  static const bool showReleaseCount = false;

  /// §6 / §7 / §12.4: "100+ production defects resolved" (case file 02
  /// outcome and the current role's last bullet).
  static const bool showDefectCount = false;

  /// §6 / §12.5: FarmOps "signal is unreliable" constraint. Off → only the
  /// outcome card is shown.
  static const bool showFarmOpsSignalFraming = false;

  /// §4 / §12.6: "Bachelor's in Mathematics" in the About background.
  static const bool showDegreeWording = false;
}
