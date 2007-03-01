From: Ian Kent <raven@themaw.net>
Subject: Re: module development
Date: Thu, 01 Mar 2007 16:48:08 +0900
Message-ID: <1172735288.3377.7.camel@raven.themaw.net>
References: <45E4AC36.3060707@cesca.es>
	<1172628050.3461.0.camel@raven.themaw.net> <45E592E9.7040104@cesca.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45E592E9.7040104@cesca.es>
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
To: Jordi Prats <jprats@cesca.es>
Cc: autofs@linux.kernel.org

On Wed, 2007-02-28 at 15:34 +0100, Jordi Prats wrote:
> Hi all,
> I have modified autofs's source code to create an entry point for the 
> umount operation. Here I attach a patch for autofs-4.1.4
> 
> This patch will allow to create a custom umount operation. In my case I 
> need to perform an operation before mounting the fs and after. So, I 
> think this could help others.
> 
> What I need to do to contribute this code?

Sorry, you've got a bit of work to do on that patch.

When you make a patch please make the diff from a clean source tree.
The reason for this is that the diff should contain only the changes
that you're proposing so the possibility of mistakes getting through is
minimized. As it is this patch contains a more unrelated stuff than the
changes for the proposal itself. I can't really follow it well enough to
know what you're trying to do.

Ian
