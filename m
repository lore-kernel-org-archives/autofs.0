From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP entries cached forever [PATCH]
Date: Sun, 6 Nov 2005 13:05:30 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511061259470.2621@donald.themaw.net>
References: <436BEDF7.6020607@google.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <436BEDF7.6020607@google.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vince Busam <vbusam@google.com>
Cc: autofs@linux.kernel.org

On Fri, 4 Nov 2005, Vince Busam wrote:

> An ldap mountpoint will be cached forever until autofs is restarted or gets a
> SIGHUP. Does it make sense to alter the behavior to automatically age out old
> entries and re-query the ldap server every once in a while?

That's not quite right.
What about the other map types? The behaviour should be the same for all 
the maps where possible.

Changes should be noticed and the map entry updated on every mount 
request.

I decided against timing out entries and reloading the map for several 
reasons I can't remember now but it's always up for reconsideration.

I also have a couple of patches in the queue for the ldap module, one 
largely rewrites the module.

> 
> Something like this (though without the hacky environment variable config):
> http://www.sixpak.org/vince/autofs-age-ldap-cache.diff

I'll have a look.
Thanks for the contribution Vince.

Ian
