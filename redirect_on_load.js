const versions = [
    "index-1.html",
    "index-2.html",
    "index-3.html",
    "index-4.html",
    "index-5.html",
];

const randomIndex = Math.floor(Math.random() * versions.length);
const chosenFile = versions[randomIndex];

window.location.href = chosenFile;
