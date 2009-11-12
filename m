From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter to dump maps
Date: Thu, 12 Nov 2009 22:52:28 +0800
Message-ID: <4AFC212C.4010409@themaw.net>
References: <4AFC0BEB.3040808@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AFC0BEB.3040808@s3group.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Ondrej Valousek wrote:
> Hi Ian / all,
> 
> Is there any way to make automounter dump maps it sees? I was just
> thinking about it - with files / NIS / program backend it is not much
> needed but it could be quite helpful with ldap backend - restarting
> automounter with verbose logging is not too practical in the production
> environment.

No, there isn't but you don't need to restart autofs to change the log
level. You can do that for the running deamon by:

automount --set-log-priority debug <master map mount point path>

and set it back to no logging (or another lower level) by:

automount --set-log-priority info <master map mount point path>

> 
> I would imagine either some small standalone program using autofs
> internals which would dump all (or certain specified) maps or running a
> second instance of autofs (with some parameter) which would not mount
> anything and just dump the maps and exits.

Not sure but we would probably do something similar to the log level
changing method above.

> 
> Is this a completely misplaced idea or is there a way to achieve this
> functionality now?

It's not a bad idea but I wonder how useful it really is since what is
really useful in trying to sort out problems is the debug log output.

> 
> Many thanks,
> Ondrej
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
