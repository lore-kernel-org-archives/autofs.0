From: Ian Kent <raven@themaw.net>
Subject: Heads up - recent patch series post to autofs list
Date: Thu, 01 Oct 2009 15:53:15 +0800
Message-ID: <4AC45FEB.6010601@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs mailing list <autofs@linux.kernel.org>

Hi all,

Just a note about the recent autofs4 patch series posted to the list.

They have been done in response to another request to change the VFS
locking that is done during path walks.

Be aware that these patches will break autofs4 on any kernel that does
not have the patches which change the locking. I cannot say when these
and the locking change patches will make it into the mainline kernel,
but I will post again when we do know.

Also, the autofs module will deadlock on kernels with the VFS locking
change. I'm not sure yet what I will do about that in the short term but
I expect the autofs module to be removed and the autofs4 module to be
renamed to autofs in the relatively near future.

Ian
