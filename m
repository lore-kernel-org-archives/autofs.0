From: Ian Kent <raven@themaw.net>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Tue, 16 Sep 2008 20:30:31 +0800
Message-ID: <1221568231.3084.31.camel@raven.themaw.net>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
	<1221142584.28271.15.camel@raven.themaw.net>
	<48CB1F71.50407@edcint.co.nz>
	<1221275360.2965.3.camel@raven.themaw.net>
	<48CBB26A.2040205@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48CBB26A.2040205@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Sat, 2008-09-13 at 22:30 +1000, Matthew Jurgens wrote:
> Debug Log:
> 

snip ...

> Sep 16 01:03:13 tempgw automount[17954]: mounted /smb/xp0
> Sep 16 01:03:13 tempgw automount[17954]: do_mount: //xp0/C\
> $ /smb//smb/xp0/C$ type cifs options username=USER,password=PASSWORD
> using module generic
> Sep 16 01:03:13 tempgw automount[17954]: mount_mount: mount(generic):
> calling mkdir_path /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: mount_mount: mount(generic):
> calling mount -t cifs -s -o username=USER,password=PASSWORD //xp0/C\
> $ /smb/xp0/C$

This is the mount command we actually use.
We get rid of the quotes during the parsing of the entry but still the
backslash quote could be causing a problem. Do you agree or should I be
looking elsewhere?

> Sep 16 01:03:13 tempgw automount[17954]: mount(generic):
> mounted //xp0/C\$ type cifs on /smb/xp0/C$
> Sep 16 01:03:13 tempgw automount[17954]: send_ready: token = 345
> Sep 16 01:03:13 tempgw automount[17954]: mounted /smb/xp0/C$

Ian
