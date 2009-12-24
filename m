From: Stef Bon <stef@bononline.nl>
Subject: Re: sshfs and autofs
Date: Thu, 24 Dec 2009 15:12:57 +0100
Message-ID: <4B3376E9.2040403@bononline.nl>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl> <1261391275-sup-7258@nixos>
	<4B311928.9070503@bononline.nl> <1261518309-sup-4721@nixos>
	<4B329000.3060101@bononline.nl> <4B3292D4.5040106@bononline.nl>
	<1261606324-sup-8574@nixos> <4B329A33.5000901@bononline.nl>
	<1261608555-sup-8913@nixos>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1261608555-sup-8913@nixos>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Marc Weber <marco-oweber@gmx.de>
Cc: autofs <autofs@linux.kernel.org>

Marc Weber wrote:
> Excerpts from Stef Bon's message of Wed Dec 23 23:31:15 +0100 2009:
>   
>> Marc Weber wrote:
>>     
>>> Excerpts from Stef Bon's message of Wed Dec 23 22:59:48 +0100 2009:
>>>   
>>>       
>>>> Stef Bon wrote:
>>>>     
>>>>         
>>>>> This is the whole problem, because this is not easy. The automounter 
>>>>> (read man 5 autofs) can offer variables like USER, UID, etc,HOST
>>>>> of the user requesting the mount (according to the manpage). Then to 
>>>>> present this user a suitable dialog... maybe via dbus???
>>>>>       
>>>>>           
>>>> I'm silly here, the user is not the problem, this is already available, 
>>>> in the options, or - in my construction - in the config file, in the 
>>>> parameter AUTOFS_USER
>>>> and in the mountpath, but the environment this user is using! A pid of 
>>>> the process would be very usefull, for example.
>>>> But this is not easy. When I'm logged in twice with the same account, 
>>>> which session should get the question for the passphrase?
>>>>     
>>>>         
>>> About which session are you talking now? A ssh-agent session determined
>>> by SSH_AGENT_PID and SSH_AUTH_SOCKET ?
>>>
>>> Add this to your .bashrc or .zshrc:
>>>
>>> reuseSSHAgent () {
>>>         local f=~/.current-ssh-agent
>>>         . $f || true
>>>         ps -p "$SSH_AGENT_PID" &> /dev/null || {
>>>                 ssh-agent | grep -v echo > $f
>>>                 . $f
>>>                 ssh-add
>>>         }
>>> }
>>> reuseSSHAgent
>>>
>>> If there is a ssh agent running it will be used if not it will be
>>> started. Then ssh-add will be run (I use only one key so this is
>>> comfortable to me ..)
>>>
>>> Maybe I should check that the socket file exists then I would'nt have to
>>> run ps.
>>>
>>> Gentoo has a nice script called "keychain" which provides this and more
>>> for ssh-agent and the gnu-gpg agent. However I felt it was too bloated
>>> and replaced it by this function.
>>>
>>> You really don't want to type your password twice, do you ? :)
>>>   
>>>       
>> No, but sometimes inevitable.
>>
>> I'm talking about the usersession. When logged in twice, and I'm 
>> activating the mount at the second session (or login)
>> how does the automounter and the mount script know which usersession to 
>> present a dialog.
>>
>> This is no issue when you first enter the passphrase manually in the 
>> first session, make use of it and reuse it on the second.
>>
>> Stef
>>     
>
> How does wall work ?
> Maybe it should be asked on all terminals.
> This would work.
> But that's the reason why I didn't even try to find a solution.
>
> If automount knew about the process id there might be a chance figuring
> out about the tty being used..
>
> But it's not a problem for me so I won't fix it unless you have an idea
> which can be implemented fast.
>
> Marc Weber
>
>   

Well maybe PAM can help you here.

If you login with a password through pam, there are pammodules which can 
do something with
the authentication. Long time ago I've setup a pam constrcution which 
stores the username and the
password in a file. The module I used was pam_script.so, which is 
developed not by the PAM team,
but since some time there is pam_exec.so, which does the same.

My login file in /etc/pam.d looks like:


#%PAM-1.0
auth            required        pam_shells.so
#auth           required        pam_env.so readenv=0
auth            required        pam_script.so 
onauth=/etc/security/onauth.ldap expose=authtok       (A)
auth            sufficient      pam_ldap.so use_first_pass
auth            required        pam_script.so expose=authtok   (B)
auth            required        pam_unix.so audit md5 shadow try_first_pass

account         required        pam_nologin.so
account         sufficient      pam_unix.so
account         optional        pam_ldap.so

password        sufficient      pam_unix.so try_first_pass use_authtok 
md5 shadow
password        required        pam_ldap.so

session         required        pam_script.so runas=root   (C)
session         optional        pam_limits.so
session         required        pam_ck_connector.so
session         optional        pam_mail.so dir=/var/mail standard
session         required        pam_unix.so shadow md5
session         required        pam_ldap.so


Let me explain what happens here:

at (A) the modules pam_script asks for a password, and exposes to the 
script onauth.ldap. This script is in the /etc/security directory. Of 
this option
is not supplied the default script onauth is run.

The onauth.ldap script is a symlink to onauth. It stores the password, 
in the environment var PAM_AUTHTOK in a file on a temporary drive,
created at boottime, on my system at /var/run/safe:

tmpfs   on     /var/run/safe type tmpfs (rw,size=500k)

It's of course protected that only root can access these passwords, and 
the user self.
Earlier I've also used encryption here, but a temporary drive which does 
not exist when the system is down is sufficient.


Now the onauth.ldap script stores the password the 
/var/run/safe/sbon/ldap dir, in the password.tmp file, and it creates a 
symlink to it like:

/var/run/safe/sbon/latest -> /var/run/safe/sbon/ldap

assuming sbon (me) is trying to login.

I wanted to make it obvious which authentification service has been 
successfull.
Next is the pam_ldap.so module.
Now if succesfull, all futher modules in the auth fase are skipped, and 
it jumps to the session fase, to open a session.

If not successfull, it will go to (B), which runs the onauth script. 
This will create the /var/run/safe/sbon/local directory, also
containing a password.tmp file with the provided password, and removes 
the /var/run/safe/sbon/latest dir, with all the contents,
and recreates the symlink:

/var/run/safe/sbon/latest -> /var/run/safe/sbon/local

If this is still not successfull, nothing happens futher here, login is 
denied. (maybe there should also be a pam_script here: cleaning up)

If successfull it jumps to the session fase.

There is also a pam_script in the session fase, running the 
/etc/security/onsessionopen script.
This looks for a password.tmp file in the /var/run/safe/sbon/latest and 
moves it to the password file.
It's obvious that the password stored in this file is the right one.

Next it runs scripts it find in the 
/etc/session.d/pam/onsessionopen/*.sh directory.
One thing done on my system is done by a create_smb_credentialfile.sh, 
which creates a mount.smb.cred file, also in
/var/run/safe/sbon/latest dir, which is used by other programs later 
like the mounting of SMB shares through cifs. I'm having
a central account database stored in ldap, which is used for my logins 
(through pam_ldap.so) and for the Samba servers. This
way I can login my samba servers with the same credentials I've provided 
at login.


Now to get back to your ssh problem, it is not so hard to make in stead 
of creating a credentialsfile, running ssh-agent, and ssh-add.
The only issue here is that you have to use the same passphrase for your 
ssh id keys as your password you login with (or a converted unique value 
of that,
like the md5key).
Next is to make ssh-add make use of the passphrase in the password file, 
or an environment var, or from stdin like cat password | ssh-add
or something...
(or something like cat password | md5sum | awk '{ print $1 }'  | ssh-add 
....)


This works but is hell to maintain when your password is changed, and 
you are working on more than one machine. The keys are not mainainted 
centrally
on a server (like kerberos) but on every host you work.

Hope this is what you're looking for.

Stef
