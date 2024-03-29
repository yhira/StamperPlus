{=========================================================================

                        MessageDef.pas

 =========================================================================}
unit MessageDef;

interface

uses Windows;

var
  //グローバルマウスメッセージ
  GWM_MOUSEFIRST,
  GWM_MOUSEMOVE,
  GWM_LBUTTONDOWN,
  GWM_LBUTTONUP,
  GWM_LBUTTONDBLCLK,
  GWM_RBUTTONDOWN,
  GWM_RBUTTONUP,
  GWM_RBUTTONDBLCLK,
  GWM_MBUTTONDOWN,
  GWM_MBUTTONUP,
  GWM_MBUTTONDBLCLK,
  GWM_MOUSEWHEEL,
  GWM_MOUSELAST: Cardinal;

implementation

const
  GWM_MOUSEMOVE_MESSAGE     = 'GWM_MOUSEMOVE_MESSAGE';
  GWM_LBUTTONDOWN_MESSAGE   = 'GWM_LBUTTONDOWN_MESSAGE';
  GWM_LBUTTONUP_MESSAGE     = 'GWM_LBUTTONUP_MESSAGE';
  GWM_LBUTTONDBLCLK_MESSAGE = 'GWM_LBUTTONDBLCLK_MESSAGE';
  GWM_RBUTTONDOWN_MESSAGE   = 'GWM_RBUTTONDOWN_MESSAGE';
  GWM_RBUTTONUP_MESSAGE     = 'GWM_RBUTTONUP_MESSAGE';
  GWM_RBUTTONDBLCLK_MESSAGE = 'GWM_RBUTTONDBLCLK_MESSAGE';
  GWM_MBUTTONDOWN_MESSAGE   = 'GWM_MBUTTONDOWN_MESSAGE';
  GWM_MBUTTONUP_MESSAGE     = 'GWM_MBUTTONUP_MESSAGE';
  GWM_MBUTTONDBLCLK_MESSAGE = 'GWM_MBUTTONDBLCLK_MESSAGE';
  GWM_MOUSEWHEEL_MESSAGE    = 'GWM_MOUSEWHEEL_MESSAGE';

initialization
  GWM_MOUSEMOVE     := RegisterWindowMessage(GWM_MOUSEMOVE_MESSAGE);
  GWM_LBUTTONDOWN   := RegisterWindowMessage(GWM_LBUTTONDOWN_MESSAGE);
  GWM_LBUTTONUP     := RegisterWindowMessage(GWM_LBUTTONUP_MESSAGE);
  GWM_LBUTTONDBLCLK := RegisterWindowMessage(GWM_LBUTTONDBLCLK_MESSAGE);
  GWM_RBUTTONDOWN   := RegisterWindowMessage(GWM_RBUTTONDOWN_MESSAGE);
  GWM_RBUTTONUP     := RegisterWindowMessage(GWM_RBUTTONUP_MESSAGE);
  GWM_RBUTTONDBLCLK := RegisterWindowMessage(GWM_RBUTTONDBLCLK_MESSAGE);
  GWM_MBUTTONDOWN   := RegisterWindowMessage(GWM_MBUTTONDOWN_MESSAGE);
  GWM_MBUTTONUP     := RegisterWindowMessage(GWM_MBUTTONUP_MESSAGE);
  GWM_MBUTTONDBLCLK := RegisterWindowMessage(GWM_MBUTTONDBLCLK_MESSAGE);
  GWM_MOUSEWHEEL    := RegisterWindowMessage(GWM_MOUSEWHEEL_MESSAGE);
  GWM_MOUSEFIRST := GWM_MOUSEMOVE;
  GWM_MOUSELAST  := GWM_MOUSEWHEEL;

end.
