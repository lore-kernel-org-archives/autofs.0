From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with NIS maps
Date: Tue, 31 Aug 2004 21:13:04 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408312110390.2756@raven.themaw.net>
References: <4133F97E.8060509@cjs226.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4133F97E.8060509@cjs226.com>
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
To: Clif Smith <kernel@cjs226.com>
Cc: autofs@linux.kernel.org

On Mon, 30 Aug 2004, Clif Smith wrote:

> I'm in a large heterogeneous environment located across multiple 
> locations.  I use NIS maps such as:
> /home -rw austin:/export/home boston:/export/home phoenix:/export/home
> 
> with the following in /etc/auto.master:
> /nis      yp      auto_indirect_nis
> 
> With AIX and Solaris, automounter chooses the server with the fewest
> hops to determine which server to mount from.  Unfortunately, it appears
> Suse's 8.1 implementation of automounter (v3.1.7-556) seems to choose 
> the first listed.

Sorry, SuSE have chosen not to update to autofs v4.

The most recent version handles this.

You may wish to try building the SRPM from one of the FC distributions.

Ian
