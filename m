From: "Craig Schreiner" <nzzjw8q02@sneakemail.com>
Subject: Re: smbfs credentias
Date: 4 Apr 2005 20:27:00 -0000
Message-ID: <20065-08925@sneakemail.com>
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

> From: Jeff Moyer jmoyer at redhat.com
> Date: Wed Jan 5 10:34:18 PST 2005
>
> ==> Regarding [autofs] smbfs credentias; abo <abo at brujulatelecom.com> adds:
>
> abo> hi!  im trying to mount smbfs resources from an ldap
>
> abo> if i put in nisMapEntry this
>
> abo> -fstype=smbfs,credentials=/home/abo/smb.creds
>
> abo> everything is working right. then i want to do it per user but
> abo> variable substitution doesn't work, i tried:
>
> abo> -fstype=smbfs,credentials=/home/$USER/smb.creds
>
> abo> -fstype=smbfs,credentials=/home/${USER}/smb.creds
>
> abo> -fstype=smbfs,credentials=~/smb.creds
>
> abo> but no succes.
>
> abo> how can i get per user credentiasl? im on the wrong direction?
>
> The automounter runs as user root.  It has no way of knowing which user
> requested a given mount.
>
> -Jeff

Wow, I'm really surprised that there isn't some mechanism to support multiple users?  While this credential mechanism might be okay for a test lab or a single user LAN, but what do people do in a business/enterprise environment?

Is there anyway to force the automounter to prompt for username and password?

Maybe I should ask, why is there no way of the automounter knowing which user is requesting a given mount?  I mean no disrespect, but does anyone else think this is a design limiting security risk implementation when automounting smbfs types?

--z
