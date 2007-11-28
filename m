From: Stef Bon <stef@bononline.nl>
Subject: Re: user token
Date: Wed, 28 Nov 2007 17:49:50 +0100
Message-ID: <200711281749.50467.stef@bononline.nl>
References: <4a3f02760711260149g1f5be5f9q9fcd2ea5d364b95@mail.gmail.com>
	<1196129844.3973.16.camel@raven.themaw.net>
	<4a3f02760711270019t5416794bh40a3e3a15d07fd90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4a3f02760711270019t5416794bh40a3e3a15d07fd90@mail.gmail.com>
Content-Disposition: inline
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

On Tuesday 27 November 2007 09:19:35 muzzol wrote:
> 2007/11/27, Ian Kent <raven@themaw.net>:
> > What is it that you need that the standard environment I mentioned
> > doesn't provide?
> >
> 
> for example sending a message to user with zenity. for identifying
> wich user is performing the request i must do some tricky things now,
> and only works on stations with just one user logged in.
> 
> exposing some user variables _inside_ executable mappings would help a
> lot with mounts that need some interaction from user.
> 
> look out this pseudo-code:
> 
> if user request for samba mount
>   if not exists credentials file
>     ask for credentials
> 
> as i said, i got a working script, but is very dirty and specific.
> 
> 
Well i've done something like this. Look at:

http://www.howtoforge.com/automatic_discovery_mounting_smb_networkshares

I've been struggling with this question some time, and found a good way to deal with this USER
variable.

In short:
. there are some scripts which are run by fcron which maintain a cache. These scripts make use of nbtscan (systemwide) and
smbclient (per user) to find all hosts and shares. The latest make use of a credentialsfile (if found, if no then guest).
. one of the mainthings these script create is a "windows network tree" in the homemap of all users logged in:
~/Global Network/Windows Network/Host A/first share A
                                                                             second share A
                                                                 Host B/first share B
                                                                              second share B

The shares are symbolic links. For example the first share A of host A points to:

/mnt/autofs/user/%USER%/smb/Host A/first share A

Now on this directory my automount program is active (which for this user is started 
when he logs in, but still is running as root), with only:

auto.hosts and auto.share which look like:

auto.hosts in the /var/run/autofs/user/%USER%/smb directory

#!/bin/bash

echo "-fstype=autofs,-Dhost=${host} file:/var/run/autofs/user/%USER%/smb/auto.share"


and auto.share also in the /var/run/autofs/user/%USER%/smb directory

* ${host}:/&
*   -fstype=smb ://${host}/&

Now this smb filesystem does not exist (only cifs and smbfs right?) I've created a script 
mount.smb which calls mount.cifs (or mount.smbfs).

To this program no variable is know which can identify the user. Simular to your problem.

Now when you look at the mountpoint, the  mountpoint is always something like:

/mnt/autofs/user/%USER%/smb/somehost/someshare

so with a program like cut you can extract the exact userid:

userid=$(echo $mountpoint | cut --delimiter "/" --fields 5 )

If this is found,
you can check in the userhomedirectory for a credentialsfile.

If found, the script will call the right mountprogram (mount.cifs or mount.smbfs)
with the credentialsfile. If not there, it will do a guest mount.

Note that this construction in my mail here is newer than in the howto on howtoforge.

I'm running this at home, and it's very good.

Hope this helps,

Stef Bon
Voorburg
the Netherlands
