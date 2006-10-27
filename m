From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: /net support
Date: Fri, 27 Oct 2006 19:04:04 -0400
Message-ID: <x49k62lnyxn.fsf@segfault.boston.devel.redhat.com>
References: <200610272022.k9RKMVk5020007@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200610272022.k9RKMVk5020007@jetcar.spd.analog.com> (David
	Meleedy's message of "Fri, 27 Oct 2006 16:22:31 -0400")
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] /net support; David Meleedy <david.meleedy@analog.com> adds:

david.meleedy> Are there any plans to implement this correctly?  We are
david.meleedy> seeing problems with the auto.net script that just loads up
david.meleedy> every directory provided by the machine.  For example some
david.meleedy> of our fileservers have a lot of mounts, and this can really
david.meleedy> start filling up the mount table.  Also, some fileservers
david.meleedy> let certain clients mount some of the directories provided
david.meleedy> but not others.  The error messages are confusing our user's
david.meleedy> because they are trying to cd to:

david.meleedy> /net/<machine_name>/foo and they see an error message about
david.meleedy> not being able to mount /net/<machine_name>/goo

david.meleedy> It would be a lot cleaner if only the directory you are
david.meleedy> cd'ing to got mounted instead of every directory.

Autofs version 5 gets this right.

-Jeff
