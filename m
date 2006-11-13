From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Re: autofsv5 enhancement - map names in /proc/mounts
Date: Mon, 13 Nov 2006 10:09:12 +0000
Message-ID: <45584448.2000102@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
	<45546B1F.5030306@ggr.co.uk> <1163213639.3113.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1163213639.3113.15.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> 
> I thought about doing this but how do you handle
> 
> /home	/etc/auto.server1.home
> /home	/etc/auto.server2.home
> 
> What map name will you use?

    Given that there can only be one map active at a mountpoint, and the 
first one wins (which is why the -null map works) that would be 
/etc/auto.server1.home,

> /home	/a very long path/map.map
> 
> etc. ...

    Yes - perhaps more of a problem, but:

a) is there any limit to the line length?
b) can you actually get space-containing paths into use through the parser?

   For b), if you can't it's not an issue, if you can you could URI 
encode it?
