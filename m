From: Ian Kent <raven@themaw.net>
Subject: Re: compatibility with solaris '[no]browse' mount option
Date: Tue, 15 Jun 2004 09:48:08 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406150946580.6253@wombat.indigo.net.au>
References: <16589.63971.33237.4865@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16589.63971.33237.4865@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 14 Jun 2004, Jeff Moyer wrote:

> Hello,
> 
> I've currently got a request to support the browse mount option.  It seems
> do-able entirely in the init script (and this seems the right place).
> Would there be any objections to such an approach?

Yes it's a daemon option.

I'll check on the submount issue.

Ian
