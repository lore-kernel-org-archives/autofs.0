From: "Simpson, Richard" <Richard.Simpson@wgint.com>
Subject: RE: automount 4.1.3: unmount timeout not working
Date: Fri, 28 Jan 2005 23:40:23 -0600
Message-ID: <07C997312C46834CBC7C3B04A6FFABA406A56805@wgiptcemx01.wgint.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net, Pavel Troller <patrol@sinus.cz>
Cc: autofs@linux.kernel.org


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org
> [mailto:autofs-bounces@linux.kernel.org]On Behalf Of raven@themaw.net
> Sent: Friday, January 28, 2005 9:00 PM
> To: Pavel Troller
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] automount 4.1.3: unmount timeout not working
> 
> I'll have a look but does this work if you set the timeout to 
> 4 seconds or 
> above?
> 
For the record, I'm having _exactly_ the same problem as Pavel, on three different workstations all using Gentoo w/ a 2.6.10 kernel, and autofs 4.1.3. I even tried a knoppix 3.7 liveCD and got the same results (2.6.9 kernel and autofs 4.1.3). That would seem to rule out the distro, the kernel, and even me, since the liveCD is preconfigured. I've also tried a lot of different timeouts with no luck.

Richard
