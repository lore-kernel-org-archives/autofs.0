From: Ian Kent <raven@themaw.net>
Subject: Re: problem with autofs
Date: Tue, 07 Nov 2006 23:16:53 +0800
Message-ID: <1162912613.18975.59.camel@localhost>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-11-07 at 09:47 -0500, Jeff Moyer wrote:
> syedk> /home ldap:server.testlab.com:ou=auto.home,dc=testlab,dc=com
> 
> syedk> in the /etc/auto.master file and say Service autofs status
> 
> syedk> Then i see the mount point as the above.But when i try to login on the
> syedk> client side.Still it doesn't mount the user's home directory.

You refer to "the client side", you do mean the client that is running
autofs with the configuration you describe above, don't you?

Ian
