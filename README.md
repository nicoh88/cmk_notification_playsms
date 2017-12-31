# check_mk - Notification Skript - playSMS Gateway

##### Quick 'n Dirty Scripting | nicht schön, aber selten

Bei diesem Bash-Skript handelt es sich um ein Benachrichtigungsskript für check_mk.
`playsms-webservices.sh` verschickt eine SMS an die im Benutzer hinterlegte Telefon- bzw. Handynummer (`Pager address`).

Folgende Variablen müssen angepasst werden:

 * `PLAYSMSUSER` - User-ID eures PlaySMS Webservice Users
 * `PLAYSMSPW` - User-Token eures PlaySMS Webservice Users
 * `PLAYSMSURL` - HTTP/HTTPS URL zu eurer PlaySMS Installation (inkl. index.php | https://sub.domain.com:443/playsms/index.php)

Das Skript gehört bei einer OMD-Installation in das Verzeichnis `/omd/sites/sitename/local/share/check_mk/notifications/` und muss natürlich mit `chmod` sowie `chown` für den OMD-User ausführbar gemacht werden. In den WATO Benutzereinstellungen kann dann bei *Flexible Notifications* **SMS via playSMS Gateway** ausgewählt und konfiguriert werden.

![cmk-wato-user-notifications.jpg](cmk-wato-user-notifications.jpg?raw=true "cmk-wato-user-notifications.jpg")

Viel Spaß!

##### Inspiration & Dank
 * [bbhenry - email-sms-custom.sh](https://github.com/bbhenry/check_mk_server/blob/master/email-sms-custom.sh)
 * [check_mk - Flexible Notifications](https://mathias-kettner.de/checkmk_flexible_notifications.html)