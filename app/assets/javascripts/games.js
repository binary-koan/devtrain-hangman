jQuery(function($) {
  function openSelect() {
    $(this).closest('.letter-select').addClass('open');
  }

  function closeSelect() {
    $(this).closest('.letter-select').removeClass('open');
  }

  $('.letter-select input[type=text]').focus(openSelect).blur(closeSelect).on('input', function() {
    if ($(this).val()) closeSelect.call(this);
    else openSelect.call(this);
  });

  $('.letter-select button').mousedown(function() {
    $(this).closest('.letter-select').find('input[type=text]').val($(this).text());
  });
});
