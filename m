From: raven@themaw.net
Subject: RE: Exporting UID to userspace?
Date: Wed, 9 Jun 2004 00:28:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406090017110.22861@donald.themaw.net>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A3@frodo.avalon.ru> 
 <Pine.LNX.4.58.0406080901490.17060@wombat.indigo.net.au>
 <1086700328.20393.38.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1086700328.20393.38.camel@brilong-lnx2.cisco.com>
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
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

On Tue, 8 Jun 2004, Brian Long wrote:

> 
> > Fact is I'm still struggling to get bugs fixed. When that has settled down 
> > there are a couple of quite serious limitations with autofs that need to 
> > be addressed. They've been outstanding for many months.
> 
> Ian,
> 
> Could you remind us what "serious limitations" still exist in autofs? 
> Is this in comparison to Sun's implementation on Solaris or something
> else?

Lazy mounting of multi-mount map entries.
Direct mounts obscure underlying file system high up in the tree.

Yes this is what people expect from an automounter as Suns implementation 
provides it. In any case I've needed it for ages and I have some fairly 
clear ideas on how to implement it, after having given it much thought.

Don't get me wrong here, the big issue with this request is working out a 
way to get hold of the UID and GID or perhaps GIDs without having to 
compromise the existing system.

Do you guys have any ideas on how we might do this?

Ian
