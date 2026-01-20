Accessibility Checklist

- Keyboard-only operation: ensure all controls have keyboard bindings and focus states.
- Color contrast: verify text/background contrast (WCAG AA) for UI elements.
- Screen reader labels: add `aria-label` where appropriate (buttons, toggles).
- Focus outline: keep visible focus ring for interactive elements.
- Reduce motion: respect `prefers-reduced-motion` to disable non-essential animations.

Suggested fixes:
- Add `aria-live` region for score/level updates.
- Provide a high-contrast theme toggle.
- Ensure canvas has fallback or description for non-visual users.
