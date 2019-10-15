$(document).ready(function(){
    $(document).on('click', '#editFilm', function(){
        $('#formEdit').html('\
            <form method="POST" action="/editarFilme" style="width:50%">\
                <div class="input-group" style="padding:5px">\
                    <input class="form-control" type="text" name="filme_old" value="' + $(this).attr('data-id') + '" style="display:none">\
                    <input class="form-control" type="text" name="filme" style="width:75%">\
                    <button class="form-control" type="submit" class="btn btn-light" id="saveEdit"><i class="far fa-save"></i></button>\
                </div>\
            </form>\
        ');
    });
 });