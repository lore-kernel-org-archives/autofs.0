From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] Maintain backwards compatibility w/ local file maps w/o
 etc.
Date: Thu, 21 Oct 2004 10:41:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410211040430.4454@wombat.indigo.net.au>
References: <1098291410.3527.18.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1098291410.3527.18.camel@localhost.localdomain>
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
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Wed, 20 Oct 2004, Chris Feist wrote:

> This patch maintains the same behavior as in previous versions of
> rc.autofs.in.  In the past you could have the following in your
> auto.master file and it would test to see if there was a local
> /etc/auto.misc file, and if there was it would use it.
> 
> /misc auto.misc
> 
> Now, it doesn't check.  I've attached a patch that fixes this behavior
> (I think debian does the same thing with their autofs patches as well).

But this is a file map not a program map?

Ian
