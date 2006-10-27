From: David Meleedy <david.meleedy@analog.com>
Subject: /net support
Date: Fri, 27 Oct 2006 16:22:31 -0400
Message-ID: <200610272022.k9RKMVk5020007@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


Are there any plans to implement this correctly?  We are seeing
problems with the auto.net script that just loads up every
directory provided by the machine.  For example some of our
fileservers have a lot of mounts, and this can really start
filling up the mount table.  Also, some fileservers let certain
clients mount some of the directories provided but not others.
The error messages are confusing our user's because they are
trying to cd to:

/net/<machine_name>/foo
and they see an error message about not being able to mount
/net/<machine_name>/goo

It would be a lot cleaner if only the directory you are cd'ing
to got mounted instead of every directory.


Thanks,

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
