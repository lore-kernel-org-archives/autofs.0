From: Ian Kent <raven@themaw.net>
Subject: Re: newly added heirarchical mount points not found
Date: Thu, 26 Feb 2004 10:08:51 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402261005100.23211@wombat.indigo.net.au>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com> 
	<1077211301.19371.34.camel@brilong-lnx2.cisco.com> 
	<Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
	<1077284694.21595.54.camel@brilong-lnx2.cisco.com>
	<403AA2A7.3010409@motorola.com><403CAEBB.6010003@motorola.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <403CAEBB.6010003@motorola.com>
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
To: Tom Georgoulias <tom.georgoulias@motorola.com>
Cc: autofs@linux.kernel.org

On Wed, 25 Feb 2004, Tom Georgoulias wrote:

> Thank you for your help on this.
> 
> Ian Kent wrote:
> 
> > Browsable mount points are a must. 
> 
> For this to work?  Or just to get all the benefits of autofs4?

Just for your sanity.

> 
> > Anyway try the HUP signal.
> 
> I wasn't successful.  On a Red Hat Linux 8.0 system using autofs-4.1.0-2 
> and the autofs4-20031201 kernel module:
> 
> 1. Made a test mount entry and pushed out the change
> 
> hatfield3:tomg$ ypmatch -k sync_caches auto.design
> sync_caches <snip>
> /tomg_test -suid bender:/export/bender/tomg/tmp/tomg_test
> <snip>

What is that "/" doing here?

I thought an indirect map did not have slashes in the key.


What does the master map say?

Ian
