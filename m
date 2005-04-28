From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Q: Does nsswitch and/or +ypmapname work for indirect
	maps?
Date: Thu, 28 Apr 2005 14:20:25 -0400
Message-ID: <17009.10601.345139.298046@segfault.boston.redhat.com>
References: <37886.67.79.20.83.1114701556.squirrel@www.prettygood.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <37886.67.79.20.83.1114701556.squirrel@www.prettygood.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Brian Stevens <brian@stevens.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Q: Does nsswitch and/or +ypmapname work for indirect maps?; "Brian Stevens" <brian@stevens.com> adds:

brian> Should the "+ypmapname" and/or nsswitch.conf allow an indirect map
brian> to pick up entries from both a local file AND a NIS map?  I have
brian> tried many revisions of autofs 4.1.3 with kernels 2.4.21 and 2.6.x,
brian> and what I am experiencing does not seem to correlate with the
brian> ChangeLogs I've read.

brian> I have an auto.master map which includes "/apps auto.apps".
brian> auto.apps is distributed via NIS.  I would like, on one host, to
brian> override one of the NIS entries with a local one.  I created a local
brian> /etc/auto.apps with "oracle hous0117:/vol/vol013/oracle-hous0138".
brian> I would like the /apps automount to use that local entry from
brian> oracle, but also grab any other entries from the NIS map.  I have
brian> found that I can get the indirect map to use the local file OR the
brian> NIS map, but not both.

brian> Is that possible?  Should it work?

AFAICT, the +mapname syntax is not currently supported in indirect maps.
This should be a todo item.

-Jeff
