From: Ian Kent <raven@themaw.net>
Subject: Re: Exporting UID to userspace?
Date: Thu, 10 Jun 2004 09:13:10 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406100911000.6687@wombat.indigo.net.au>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841AA@frodo.avalon.ru>
 <40C75A89.4020002@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40C75A89.4020002@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

On Wed, 9 Jun 2004, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dimitry V. Ketov wrote:
> >>-----Original Message-----
> >>From: autofs-bounces@linux.kernel.org
> >>
> >>If the idea is to have a 'Network Neighborhood' inside each
> >>user's homedir, you could write an executable map for /home
> >
> >
> > It will hide /home directory content.
> 
> No. It wouldn't presuming that your /home subdirs are automounted.  The
> script would basically transform map entries like:
> 
> mikew	-wsize=32768,rsize=32768  homedirserver:/export/home/mikew
> 
> Into:
> mikew	-wsize=32768,rsize=32768  homedirserver:/export/home/mikew \
>   /NetworkNeighborhood	-fstype=autofs,Duser=mikew /etc/auto_nn
> 
> which is a valid multimount and should be handled correctly by automount 4.

And this brings us to the lazy mounting issue for multi-mounts.

Got to get some more time on that.

Ian
