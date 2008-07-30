From: Ian Kent <raven@themaw.net>
Subject: Re: cache_delete_offset_list: active offset mount key
Date: Wed, 30 Jul 2008 11:32:24 +0800
Message-ID: <1217388746.2999.0.camel@raven.themaw.net>
References: <20080729183800.GB11329@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080729183800.GB11329@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org


On Tue, 2008-07-29 at 11:38 -0700, Chris Walker wrote:
> We're seeing a bunch of these:
> 
> Jul 28 09:23:21 XXXXX automount[11830]: cache_delete_offset_list: active offset mount key /net/XXXX/data
> 
> /net/XXXX/data isn't accessible through the automounter while other
> servers are accessible through /net. The automounter has to be restarted
> to correct this.

Kernel version and debug log please.

Ian
