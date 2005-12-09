From: jtk@us.ibm.com (John T. Kohl)
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: 09 Dec 2005 08:33:45 -0500
Message-ID: <6cd5k6xume.fsf@sumu.lexma.ibm.com>
References: <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net> <1133547148.8976.25.camel@lade.trondhjem.org> <20051204125612.GA28229@infradead.org> <20051204125740.GB28229@infradead.org> <Pine.LNX.4.63.0512042256380.31847@donald.themaw.net> <20051204171729.GA31111@infradead.org> <17302.157.540958.723305@segfault.boston.redhat.com> <20051206214033.GA31000@infradead.org> <1133968943.4581.22.camel@brilong-lnx> <43971FFF.2090900@us.ibm.com> <20051209121239.GA17898@infradead.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20051209121239.GA17898@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Brian Long <brilong@cisco.com>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, wtaber@us.ibm.com, Trond Myklebust <trond.myklebust@fys.uio.no>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ian Kent <raven@themaw.net>

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Wed, Dec 07, 2005 at 12:46:39PM -0500, Will Taber wrote:
>> problem at hand.  Anyway, with this information, is it appropriate for 
>> us to replace our calls to lookup_one_len with calls to path_walk or is 
>> that also forbidden?

Christoph> path_walk and firends resolve a full path.  As such they are
Christoph> definitly not suitable for stackable filesystem, they are
Christoph> intendeded only for implementating syscalls (and syscall-like
Christoph> interfaces, e.g. some ioctls)

path_lookup() takes a pathname and interprets it relative to cwd or
root, so it's definitely not useful for stacking.  But path_walk() takes
a pathname fragment and an initialized nameidata (start point), so it
*could* be used to resolve a single component, or multiple components.

If lookup_one_len() is for use within the caller's file system only, and
path_walk() is not suitable for stacking, then what calls *are* suitable
for stacking file systems to use?  We want to start with an existing
(dentry,vfsmnt) and a pathname component, converting it to the
(dentry,vfsmnt) of the result.

-- 
John Kohl
Senior Software Engineer - Rational Software - IBM Software Group
Lexington, Massachusetts, USA
jtk@us.ibm.com
<http://www.ibm.com/software/rational/>
