From: Ian Kent <raven@themaw.net>
Subject: Re: parse(sun): invalid location
Date: Fri, 16 Nov 2007 10:56:16 +0900
Message-ID: <1195178176.3131.1.camel@raven.themaw.net>
References: <592786.93213.qm@web35513.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <592786.93213.qm@web35513.mail.mud.yahoo.com>
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
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-11-13 at 20:22 -0800, Sandra Bonus wrote:
> Running autofs-5.0.1-0.rc3.33 on Fedora Core 6.
> 
> I'm trying to mount a share on a Windows 2003 server in a domain. nslookup returns the correct IP address and I can ping it.
> I have a domain username/password that gives me admin access to this server as well as to my local PC.
> For the purpose of this I create a local (not domain) user called awmelsales1 and a share called awmelsales1_backups. I do this on the server and on my PC.
> 
> 
> TEST 1:
> I can mount the share manually using 
> mount -o -fstype=cifs,username=awmelsales1,password=password //awmelfp01/awmelsales1_backups /mnt
> 
> TEST 2:
> I run auto.samba manually (using /etc/auto.samba awmelfp01) this gives me:
> -fstype=cifs,username=awmelsales1,password=password \
>          /awmelsales1_backups "://awmelfp01/awmelsales1_backups" \
>          /awmelsales2_backups "://awmelfp01/awmelsales2_backups"
> 
> TEST 3:
> I try this out on my local PC
> ls -l /smb/MYPC/awmelsales1_backups
> and it lists out all the files ie it works
> 
> At this point I assume that:
> 1 - I can manually mount so I can see the server, the share and have permissions
> 2 - autofs can successfully connect and see the shares
> 3 - it works on my PC so the names are all ok ie underscores are ok, autofs and its config is ok
> 
> However when I ls -l /smb/awmelfp01/awmelsales1_backups then I get "No such file or directory" and the log shows 
> 
> attempting to mount entry /smb/awmelfp01
> parse_mapent: parse(sun): invalid location
> failed to mount /smb/awmelfp01
> 
> What am I missing? Ideas? Help ....

I'm not sure what the problem is here.
It may help to post a debug log.
There's information on how to do this at
http://people.redhat.com/jmoyer.

Ian
