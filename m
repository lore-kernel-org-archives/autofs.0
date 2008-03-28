From: Stef Bon <stef@bononline.nl>
Subject: Re: Testing the UID var.
Date: Fri, 28 Mar 2008 12:50:28 +0100
Message-ID: <47ECDB84.5010301@bononline.nl>
References: <47ECB844.8080405@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47ECB844.8080405@bononline.nl>
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
To: autofs@linux.kernel.org

Stef Bon wrote:
> ---------
>
> #!/bin/bash
>
> key="$1"
> opts='-fstype=smbtest,auid=$UID'
>
> SMBCLIENT=/usr/bin/smbclient
>
> [ -x $SMBCLIENT ] || exit 1
>
> # echo $key
>
> $SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" 
> -F'|' -- '
>         BEGIN   { ORS=""; first=1 }
>         /Disk/  { if (first) { print opts; first=0 }; sub(/ /, "\\ ", 
> $2); print " \\\n\t /" $2, "://" key "/" $2 }
>         END     { if (!first) print "\n"; else exit 1 }
>         '
> --------
>
> Note:
> a. I've made this script I little bit simpler by letting it not search 
> the smbclient script.
> b. the fstype is not smb but smbtest. I've created a wrapper 
> mount.smbtest which will filter the parameter
> auid out. This value can be used for permissions and authentification
> c. the extra opion auid (activating user) which will be assigned when 
> the automounter does the mount, not when running this script. That's why 
> there are single quotes around it.
>   

I would like to add that the mount will use the userid of the activating 
user, but that the smbclient does a guest
lookup. It is with this construction not possible to make use of this 
"activating userid" in auto.smb. In general I find it very difficult to 
figure out a construction which does support mounting for every ordinary 
user which:
- give enough permissions so that user one cannot access other users 
mountpoint (if more than one user is logged in)
- use the activating user in the mount program as the lookup program as well


Stef Bon
