From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Automounter to dump maps
Date: Thu, 12 Nov 2009 08:43:40 -0500
Message-ID: <x49eio3svsj.fsf@segfault.boston.devel.redhat.com>
References: <4AFC0BEB.3040808@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AFC0BEB.3040808@s3group.cz> (Ondrej Valousek's message of "Thu, 
	12 Nov 2009 14:21:47 +0100")
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

Ondrej Valousek <webserv@s3group.cz> writes:

> Hi Ian / all,
>
> Is there any way to make automounter dump maps it sees? I was just
> thinking about it - with files / NIS / program backend it is not much
> needed but it could be quite helpful with ldap backend - restarting
> automounter with verbose logging is not too practical in the
> production environment.
>
> I would imagine either some small standalone program using autofs
> internals which would dump all (or certain specified) maps or running
> a second instance of autofs (with some parameter) which would not
> mount anything and just dump the maps and exits.
>
> Is this a completely misplaced idea or is there a way to achieve this
> functionality now?

Well, back in the autofs4 days, when way too much logic was put into the
init script, we basically had to do this.  ;-)  See the --dumpmap switch
in v4.  I can see that it could be a useful aid for administrators to
ensure that their maps look like they think they do, especially with
nsswitch and included maps, and those pesky null maps.

Cheers,
Jeff
