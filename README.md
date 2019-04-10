# Hitchi

__Entstanden aus der Mitfahrgelegenheit-Community auf Facebook!__

Hier werden Suchende und Fahrer aktiv einander zugeordnet! hitchi ist übersichtlich, einfach und intelligent. _Mitfahrgelegenheiten wie sie sein sollten, einfach und kostenlos!_

## Lokales Setup

### API Keys

* benenne `.env.example` in `.env` und setze die benötigten API Keys. Alle benötigten Schlüssel sind bereits vordefiniert.

1. [Facebook Account und einen API Key](https://developers.facebook.com/docs/facebook-login/access-tokens?locale=de_DE)
2. [Google Maps API Key](https://console.developers.google.com/flows/enableapi?apiid=geocoding_backend&keyType=SERVER_SIDE)

### Cloudinary (optional)

Falls du die Bildfunktion benötigst, dann erstelle ein Cloudinary Konto und speichere die `cloudinary.yml` unter `hitchi/config`

`cloudinary.yml` ist in `.gitignore` hinterlegt

## zusätzliche Infos

### OmniAuth Facebook Login

* https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
* https://github.com/plataformatec/devise/wiki/OmniAuth-with-multiple-models
