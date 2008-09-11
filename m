From: Ian Kent <raven@themaw.net>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Thu, 11 Sep 2008 22:16:24 +0800
Message-ID: <1221142584.28271.15.camel@raven.themaw.net>
References: <48C5F518.9010800@edcint.co.nz>
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48C8D7FE.9000501@edcint.co.nz>
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

On Thu, 2008-09-11 at 18:34 +1000, Matthew Jurgens wrote:
> That's interesting. Identical output from a working and the failing host.
> 
>  From a working host:
> -fstype=cifs,username=USER,password=PASSWORD \
>          /C "://xp0/C" \
>          /ADMIN\$ "://xp0/ADMIN\$" \
>          /C\$ "://xp0/C\$"
> 
> 
>  From the failing 5.0.3 host:
> -fstype=cifs,username=USER,password=PASSWORD \
>          /C "://xp0/C" \
>          /ADMIN\$ "://xp0/ADMIN\$" \
>          /C\$ "://xp0/C\$"
> 

That doesn't look quite right.
It might be an out of date script, how about posting the script as well.

> 
> Ian Kent wrote:
> > Can you post the output of the program map please.
> > That's probably "sh /etc/auto.smb <server name>".
> >
> > Ian
> >
> >
> >
> >   
