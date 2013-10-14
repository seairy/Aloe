(function($) {
    $(document).ready(function() {  

        // Collapsible Panels
        $( '.chaos-panel.chaos-collapsible' ).each(function(i, element) {
            var p = $( element ),   
                header = p.find( '.chaos-panel-header' );

            if( header && header.length) {
                var btn = $('<div class="chaos-collapse-button chaos-inset"><span></span></div>').appendTo(header);
                $('span', btn).on( 'click', function(e) {
                    var p = $( this ).parents( '.chaos-panel' );
                    if( p.hasClass('chaos-collapsed') ) {
                        p.removeClass( 'chaos-collapsed' )
                            .children( '.chaos-panel-inner-wrap' ).hide().slideDown( 250 );
                    } else {
                        p.children( '.chaos-panel-inner-wrap' ).slideUp( 250, function() {
                            p.addClass( 'chaos-collapsed' );
                        });
                    }
                    e.preventDefault();
                });
            }

            if( !p.children( '.chaos-panel-inner-wrap' ).length ) {
                p.children( ':not(.chaos-panel-header)' )
                    .wrapAll( $('<div></div>').addClass( 'chaos-panel-inner-wrap' ) );
            }
        })
    
        /* Side dropdown menu */
        $("div#chaos-navigation ul li a, div#chaos-navigation ul li span")
            .on('click', function(event) {
                if(!!$(this).next('ul').length) {
                    $(this).next('ul').slideToggle('fast', function() {
                        $(this).toggleClass('closed');
                    });
                    event.preventDefault();
                }
            });
        
        /* Responsive Layout Script */
        $("#chaos-nav-collapse").on('click', function(e) {
            $( '#chaos-navigation > ul' ).slideToggle( 'normal', function() {
                $(this).css('display', '').parent().toggleClass('toggled');
            });
            e.preventDefault();
        });
        
        /* Form Messages */
        $(".chaos-form-message").on("click", function() {
            $(this).animate({ opacity:0 }, function() {
                $(this).slideUp("normal", function() {
                    $(this).css("opacity", '');
                });
            });
        });

        // Checkable Tables
        $( 'table thead th.checkbox-column :checkbox' ).on('change', function() {
            var checked = $( this ).prop( 'checked' );
            $( this ).parents('table').children('tbody').each(function(i, tbody) {
                $(tbody).find('.checkbox-column').each(function(j, cb) {
                    $( ':checkbox', $(cb) ).prop( "checked", checked ).trigger('change');
                });
            });
        });
        
        /* File Input Styling */
        $.fn.fileInput && $("input[type='file']").fileInput();

        // Placeholders
        $.fn.placeholder && $('[placeholder]').placeholder();

        // Tooltips
        $.fn.tooltip && $('[rel="tooltip"]').tooltip();

        // Popovers
        $.fn.popover && $('[rel="popover"]').popover();
    });
}) (jQuery);

function submitForm(form) {
	$(form).submit();
	return false;
}

function redirectTo(path) {
    document.location.href = path;
}

function redirectToDestroy(path) {
	if (confirm("确定要删除吗？")) {
		var form = document.createElement("form");
		$(form).attr("action", path).attr("method", "post");
		$(form).html('<input type="hidden" name="_method" value="delete" />');
		document.body.appendChild(form);
		$(form).submit();
		document.body.removeChild(form);
  }
  return false;
}

function selectPosterRelatedType() {
	$("div[class*='related-type-']").hide('slow');
  if ($('#related_type_1').is(':checked')) {
		$('.related-type-article').show('slow');
  } else if ($('#related_type_2').is(':checked')) {
		$('.related-type-none').show('slow');
  }
}