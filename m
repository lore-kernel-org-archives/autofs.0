From: raven@themaw.net
Subject: Re: FW: [NFS] NFS and/or autofs hanging on Linux
Date: Sat, 9 Oct 2004 10:37:25 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410091036150.1370@donald.themaw.net>
References: <482A3FA0050D21419C269D13989C61130435E921@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C61130435E921@lavender-fe.eng.netapp.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Lever, Charles" <cel@netapp.com>
Cc: autofs@linux.kernel.org


Thanks Charles.

Spotted it on the NFS list but didn't copy my response here. My bad.

Basically asked if he had patched his kernel.

On Thu, 7 Oct 2004, Lever, Charles wrote:

> in case some of you guys don't hang out on the nfs mailing list....
> 
> -----Original Message-----
> From: Burke, Alan [mailto:Alan.Burke@analog.com] 
> Sent: Thursday, October 07, 2004 9:32 AM
> To: nfs@lists.sourceforge.net
> Cc: Annie Mckeon
> Subject: [NFS] NFS and/or autofs hanging on Linux
> 
> 
> Hi Everyone,
> 
> We have got a problem with NFS hanging with automounter mounts.
> 
> We're running RH8 2.4.20-20.0 kernel
> NFS-utils 1.0.1-2
> Autofs4.1.2 (we must have the /net ability)
> H/W is mixed HP4100's, Dell 2650's, Sun V60 and V65's
> All the machines are in a Sun NIS domain with 700 Sun machines that run
> fine.
> 
> The problem is intermittent; any automounter point can hang at any time.
> For example auto_home may have 1000 entries cd /home/user1 hangs and
> /home/user2 does not on machine Foo, but /home/user2 is fine on machine
> Bar.
> 
> Once hung we sometimes can get it to release by umount -at nfs others
> time a reboot is the only way to get it to release.
> 
> any help is appreciated
> 
> thanks,
> 
> alan
> 
> 
> 
> 	  
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give
> us Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find
> out more http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
