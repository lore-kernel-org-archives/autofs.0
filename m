From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Sun, 7 Dec 2003 13:53:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312071347540.2974-100000@raven.themaw.net>
References: <3FD2ADE5.6050403@kmaclub.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FD2ADE5.6050403@kmaclub.com>
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
To: Michael Blandford <michael@kmaclub.com>
Cc: autofs@linux.kernel.org


Sounds like a bug. I'll investigate.

On Sat, 6 Dec 2003, Michael Blandford wrote:

> Hello,
> 
> I am currently running autofs 3.1.7 from Fedora Core 1.  I am trying to 
> upgrade to 4.1.0-beta2 from atrpms.
> 
> I recently switched to using ldap.  I admit I dont understand it the way 
> I do NIS..but anyway.  Here is what my "map" looks like:
> 
> auto.services:
> /       fileserver:/export/services/&
> a       fileserver:/export2/a
> b       fileserver:/export2/b
> c       fileserver:/export2/c
> d       fileserver:/export2/d

This looks like a NIS map. Shouldn't the / be a * in this case and 
shouldn't the wildcard map entry come last. I thouht that the defined 
behaviour of the wildcard map entry was that once it is encountered map 
processing stops.

> 
> This works fine under 3.1.7.  With 4.1.0, cd'ing into 
> /services/<anything> results in /export2/b getting mounted.  I can't 
> understand this at all.

It might be something to with the multi-mount code getting confused.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
