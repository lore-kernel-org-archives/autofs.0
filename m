From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: name spaces good
Date: Tue, 06 Jan 2004 14:48:36 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFB3B44.9060106@zytor.com>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
	<20040106215018.GA911@sun.com>  <3FFB316A.6000004@zytor.com>
	<1073428129.2454.35.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1073428129.2454.35.camel@mentor.gurulabs.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Dax Kelson <dax@gurulabs.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, thockin@Sun.COM, Kernel Mailing List <linux-kernel@vger.kernel.org>

Dax Kelson wrote:
> On Tue, 2004-01-06 at 15:06, H. Peter Anvin wrote:
> 
>>First of all, I'll be blunt: namespaces currently provide zero benefit
>>in Linux, and virtually noone uses them.
> 
> 
> I strongly disagree.
> 
> I find them very useful, and there are lots of problems that are not
> cleanly solved any other way. In particular they are very useful in
> security hardening, compartmentalization scenarios.
> 

Excellent... if so it would be useful to have a discussion about the
proper semantics for these scenarios.  So far the consensus opinion
among most of the VFS people seems to have been "when you clone a
namespace you get an unanimated namespace"; it would be useful ito know
if that applies to your scenario, assuming it matters, and if so why/why
not.

Al Viro has been working on a key piece of infrastructure for doing
autofs right called mount traps.  This is the main reason -- even more
so than the lack of time on my part -- that not much work has been done
on the new version of autofs.  mount traps, combined with
"pseudo-symlinks" (non-S_IFLNK nodes which have follow_link methods), do
most of the tasks that have been proven necessary in the kernel.

The consensus I have seen seems to be that namespaces is mostly used, as
you said, for compartmentalizing and security, you pretty much have two
scenarios as far as I can see it:

a) You're running autofs "outside" the compartmentalization, in a global
namespace.
b) You're running autofs "inside" the compartmentalization, then you
don't want access to anything on the outside.  You thus run the autofs
"inside" and can't access anything else.

	-hpa
