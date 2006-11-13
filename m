From: Ian Kent <raven@themaw.net>
Subject: Re: autofsv5 enhancement - map names in /proc/mounts
Date: Mon, 13 Nov 2006 23:44:45 +0800
Message-ID: <1163432685.3016.21.camel@localhost>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
	<45546B1F.5030306@ggr.co.uk> <1163213639.3113.15.camel@localhost>
	<45584448.2000102@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45584448.2000102@ggr.co.uk>
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
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

On Mon, 2006-11-13 at 10:09 +0000, Gordon Lack wrote:
> Ian Kent wrote:
> > 
> > I thought about doing this but how do you handle
> > 
> > /home	/etc/auto.server1.home
> > /home	/etc/auto.server2.home
> > 
> > What map name will you use?
> 
>     Given that there can only be one map active at a mountpoint, and the 
> first one wins (which is why the -null map works) that would be 
> /etc/auto.server1.home,

Ya but for some reason I believed that I was able to do this with the
Solaris automounter and so v5 now will merge each map.

> 
> > /home	/a very long path/map.map
> > 
> > etc. ...
> 
>     Yes - perhaps more of a problem, but:
> 
> a) is there any limit to the line length?
> b) can you actually get space-containing paths into use through the parser?

An individual file name can be up to 255 characters alone.
They don't have to have spaces to be long.

How do you use this feature?

Ian
