:- module(_, [], [doccfg]).

:- include(core_docsrc(docpaths)).

output_name := 'ciao_tcltk'.

filepath := ~ciaofilepath_common.

doc_structure :=
    'tcltk/tcltk'-['tcltk/tcltk_low_level'].
     %
%  'window_class_doc',
%    'widget_class_doc',
%      'menu_class_doc',
%      'canvas_class_doc',
%      'button_class_doc',
%      'checkbutton_class_doc',
%      'radiobutton_class_doc',
%      'entry_class_doc',
%      'label_class_doc',
%      'menubutton_class_doc',
%      'menu_entry_class_doc',
%    'shape_class_doc',
%      'arc_class_doc',
%      'oval_class_doc',
%      'poly_class_doc',
%      'line_class_doc',
%      'text_class_doc',

% (chartlib moved to library.development/)
% 'chartlib/chartlib'-[
%   'chartlib/bltclass',
%   'chartlib/chartlib_errhandle',
%   'chartlib/color_pattern',
%   'chartlib/genbar1',
%   'chartlib/genbar2',
%   'chartlib/genbar3',
%   'chartlib/genbar4',
%   'chartlib/gengraph1',
%   'chartlib/gengraph2',
%   'chartlib/genmultibar',
%   'chartlib/table_widget1',
%   'chartlib/table_widget2',
%   'chartlib/table_widget3',
%   'chartlib/table_widget4',
%   'chartlib/test_format'
% ],

%doc_mainopts := no_patches.
doc_mainopts := _ :- fail. % Allow patches in main changelog (those are the release notes)
% TODO: Added no_propuses because texindex breaks with very large
%       indices (due to internal, maybe arbitrary, limitations) --JF.
doc_compopts := no_isoline|no_engmods|propmods|no_changelog|no_propuses|no_bugs.

bibfile := ~ciao_bibfile.

% TODO: port this manual
allow_markdown := no.
syntax_highlight := no.
