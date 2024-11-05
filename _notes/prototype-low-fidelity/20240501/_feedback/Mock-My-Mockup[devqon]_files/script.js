
window.onload = function() {
    var converter = new showdown.Converter(),
        text = document.getElementById('report').innerText,
        html = converter.makeHtml(text);
    document.getElementById('report').innerHTML = html;
    document.getElementById('report').style.display = 'block';
    hideLoader(); // Hide loader when page loads and content is ready
};

function previewImage() {
    var file = document.querySelector('input[type=file]').files[0];
    var reader = new FileReader();
    
    reader.onloadend = function() {
        var imagePreview = document.getElementById('imagePreview');
        imagePreview.src = reader.result;
        imagePreview.style.display = 'block';
    }

    if (file) {
        reader.readAsDataURL(file);
    } else {
        imagePreview.src = "";
    }
}

function showLoader() {
    document.getElementById('loader').style.display = 'flex';
}

function hideLoader() {
    document.getElementById('loader').style.display = 'none';
    document.getElementById('uploader').style.display = 'none';
}

// Function to display the response in the report div
function displayResponse(response) {
    var reportDiv = document.getElementById('report');
    reportDiv.innerHTML = response;
}







document.addEventListener('DOMContentLoaded', function() {
    var uploader = document.getElementById('uploader');
    uploader.addEventListener('dragover', dragOverHandler, false);
    uploader.addEventListener('drop', dropHandler, false);
    uploader.addEventListener('dragleave', dragLeaveHandler, false);
});

function dragOverHandler(e) {
    e.preventDefault();
    e.stopPropagation();
    document.getElementById('uploader').classList.add('hover');
}

function dragLeaveHandler(e) {
    e.preventDefault();
    e.stopPropagation();
    document.getElementById('uploader').classList.remove('hover');
}

function dropHandler(e) {
    e.preventDefault();
    e.stopPropagation();
    document.getElementById('uploader').classList.remove('hover');
    var files = e.dataTransfer.files;
    document.getElementById('uploadBtn').files = files;
    previewImage();
}


function previewImage() {
    var file = document.getElementById('uploadBtn').files[0];
    if (file) {
        var reader = new FileReader();
        reader.onloadend = function() {
            var imagePreview = document.getElementById('imagePreview');
            imagePreview.src = this.result;
            imagePreview.style.display = 'block';
            document.getElementById('dragText').style.display = 'none';
             
             document.getElementById('dragImg').style.display = 'none';
            document.getElementById('analyzeButton').style.display = 'inline-block';  // Make the button visible
        };
        reader.readAsDataURL(file);
    } else {
        document.getElementById('imagePreview').style.display = 'none';
        document.getElementById('dragText').style.display = 'block';
        document.getElementById('analyzeButton').style.display = 'none';  // Hide the button if no file
    }
}



function showLoader() {
    document.getElementById('loader').style.display = 'flex';
}

function hideLoader() {
    document.getElementById('loader').style.display = 'none';
    document.getElementById('uploader').style.display = 'none';
    document.getElementById('uploader_wrapper').style.display = 'none';
    
}





