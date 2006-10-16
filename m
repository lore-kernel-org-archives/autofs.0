From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automounted filesystems being unmounted
	and	mounted	every minute
Date: Mon, 16 Oct 2006 15:49:20 -0400
Message-ID: <x498xjgxcqn.fsf@segfault.boston.devel.redhat.com>
References: <1161005417.3184.5.camel@pc.ilinx>
	<1161016376.3085.86.camel@localhost>
	<1161019573.3184.15.camel@pc.ilinx>
	<x49d58sxhes.fsf@segfault.boston.devel.redhat.com>
	<1161025241.3184.34.camel@pc.ilinx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1161025241.3184.34.camel@pc.ilinx> (Brian J. Murrell's message
	of "Mon, 16 Oct 2006 15:00:41 -0400")
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
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] automounted filesystems being unmounted and mounted every minute; "Brian J. Murrell" <brian@interlinx.bc.ca> adds:

brian> On Mon, 2006-16-10 at 14:08 -0400, Jeff Moyer wrote:
>> Take a look at http://people.redhat.com/jmoyer for documentation on how
>> to gather debug information from the automounter.  Basically, you need
>> to log daemon.* somewhere.

brian> gnome-panel?

brian> $ ps -p14360 f PID TTY STAT TIME COMMAND 14360 ?  Ss 8:53
brian> gnome-panel --sm-config-prefix /gnome-panel-dbYkZn/ -

brian> I wonder why gnome-panel would be touching /autohome/share.

Please ask them!

brian> I guess what I wonder also about all of this is that isn't there
brian> some period of "idleness" required before anything is unmounted?  Is
brian> that the 60s that I am seeing?  If I increase that to a period
brian> longer than the periodic access by gnome-panel should that not stop
brian> the trashing of the mount?

You can specify the timeout in seconds for unmounts via the --timeout=XX
option.  But please pursue this with the gnome folks, as they shouldn't be
causing this problem in the first place.

Thanks!

Jeff
