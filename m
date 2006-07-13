From: Ian Kent <raven@themaw.net>
Subject: Re: -hosts and -null enabling for autofs v4.1.x
Date: Thu, 13 Jul 2006 21:10:28 +0800
Message-ID: <1152796228.23150.7.camel@raven.themaw.net>
References: <44AE7785.74E63D70@ggr.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44AE7785.74E63D70@ggr.co.uk>
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
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

On Fri, 2006-07-07 at 16:02 +0100, Gordon Lack wrote:

> PS:  I see that v5 handles these anyway.  However, this note in
> README.v5.release looks ominous...
> 
> ==========
> - a "hosts" map module has been added
>   - an entry like "/net -hosts" is now understood and uses the new
>     multi-mount semantics for lazy mount/umount of exports from the
> host.
>   - the implementation is quite simple minded at this stage and will
> need
>     refinment. It just iterates through the host table and addes any
> host
>     names it finds to the internal map.
> ==========
> 
> Some of us have thousands of hosts in a host map, eg:
> 
> systemx*[1] ypcat -k hosts | wc -l
>    30899

The hosts table is only iterated if you also specify --ghost as an
option. The internal program default is ghosting (browsing) enabled but
the installed configuration modifies the default and disables it for
backward compatibility.

So if you've got potentially large maps then the idea is to leave the
installed settings as they are.

Ian
