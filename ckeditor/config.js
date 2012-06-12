/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function(config) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    config.extraPlugins = 'syntaxhighlight';
    config.skin = 'v2';
    config.toolbar = [
		['Source', '-', 'Preview', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteWord', 'Print'],
		['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat'],
		['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'ShowBlocks'],
		'/',
		['Bold', 'Italic', 'Underline', 'StrikeThrough', '-', 'Subscript', 'Superscript'],
		['OrderedList', 'UnorderedList', '-', 'Outdent', 'Indent', 'Blockquote'],
		['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyFull'],
		['Link', 'Unlink', 'Anchor'],
		['Image', 'Flash', 'Table', 'Rule', 'Smiley', 'SpecialChar', 'syntaxhighlight'],
		'/',
		['Styles', 'Format', 'Font', 'FontSize'],
		['TextColor', 'BGColor'],
		['FitWindow', '-', 'About']
	];
};
