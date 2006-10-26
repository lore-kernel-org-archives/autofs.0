From: Ian Kent <raven@themaw.net>
Subject: Re: --timeout doesn't do anything on fedora3 or 5
Date: Thu, 26 Oct 2006 11:11:48 +0800
Message-ID: <1161832308.3789.2.camel@localhost>
References: <000301c6f89d$ce6afdb0$9600a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <000301c6f89d$ce6afdb0$9600a8c0@home>
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
To: marty <leisner@rochester.rr.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-10-25 at 21:26 -0400, marty wrote:
> On both fedora3 and fedora5, I can't get the --timeout option on autofs to 
> do anything useful.
> 
> I saw a bug report on fedora3, but getting a newer release doesn't seem to 
> make a difference.
> http://linux.derkeiler.com/Mailing-Lists/Fedora/2005-02/0488.html
> 
> Is there anyway to "monitor" the timeout interactively from user space 
> (instead of "waiting" to see if it happens,
> watch to see its counting down?)

To start with more information is needed.
See http://people.redhat.com/jmoyer and provide the information
described.

Enabling debug as described in Jeffs page will log the startup and
specify the timeout being used and log entries every time there is a
check.

Ian
