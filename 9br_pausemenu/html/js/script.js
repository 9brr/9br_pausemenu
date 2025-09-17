window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === "toggleMenu") {
        const menu = document.getElementById("menu");
        const infoBox = document.querySelector(".container"); 
        if (data.status) {
            document.body.style.display = "flex";
            if(menu) menu.style.display = "flex";
            if(infoBox) infoBox.style.display = "flex";
        } else {
            document.body.style.display = "none";
            if(menu) menu.style.display = "none";
            if(infoBox) infoBox.style.display = "none";
        }
    }

    if (data.type === "setLanguage") {
        const lang = data.lang;
        if(typeof locales !== 'undefined' && locales[lang]){
            document.getElementById("title").innerText = locales[lang].title;
            document.getElementById("playerId").innerText = locales[lang].playerId + "...";
            document.getElementById("resume").innerText = locales[lang].resume;
            document.getElementById("map").innerText = locales[lang].map;
            document.getElementById("settings").innerText = locales[lang].settings;
            document.getElementById("exitServer").innerText = locales[lang].exitServer;
            document.getElementById("confirmExit").innerText = locales[lang].confirmExit;
            document.getElementById("yes").innerText = locales[lang].yes;
            document.getElementById("no").innerText = locales[lang].no;
        }
    }

    if (data.type === "playerInfo") {
        const lang = data.lang || 'ar';
        if(typeof locales !== 'undefined' && locales[lang]){
            document.getElementById("playerId").innerText = locales[lang].playerId + data.id;
        } else {
            document.getElementById("playerId").innerText = "الهوية: " + data.id;
        }
    }
});

$(function() {

    $(".map").click(function() {
        fetch(`https://${GetParentResourceName()}/openMap`, { method: 'POST', body: JSON.stringify({}) });
    });

    $(".settings").click(function() {
        fetch(`https://${GetParentResourceName()}/openSettings`, { method: 'POST', body: JSON.stringify({}) });
    });

    $(".exit-confirm").click(function() {
        $("#menu").fadeOut(100, function() {
            $("#confirmation").fadeIn(100);
        });
    });

    $(".exit").click(function() {
        fetch(`https://${GetParentResourceName()}/exitServer`, { method: 'POST', body: JSON.stringify({}) });
    });

    $(".cancel-exit").click(function() {
        $("#confirmation").fadeOut(100, function() {
            $("#menu").fadeIn(100);
        });
    });

    $(".close-menu").click(function() {
        fetch(`https://${GetParentResourceName()}/closeMenu`, { method: 'POST', body: JSON.stringify({}) });
    });

});

window.addEventListener('load', () => {
    const exitBtn = document.querySelector('.exit');
    if (exitBtn) {
        exitBtn.addEventListener('click', () => {
            fetch(`https://${GetParentResourceName()}/kickPlayer`, { method: 'POST' });
            document.getElementById('confirmation').style.display = 'none';
        });
    }
});
