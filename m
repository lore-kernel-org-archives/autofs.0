From: Dylan <autofs@dylan.me.uk>
Subject: autofs4 and NIS
Date: Thu, 1 Jan 2004 01:59:12 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200401010159.12640.autofs@dylan.me.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@linux.kernel.org>

Hello all,

I'm currently using autofs4 to mount nfs shares. The config files are 
distributed via NIS, which overall is working without a hitch. I have 
two related problems, however...

It is, obviously, necessary to restart the NIS server from time to time, 
in order to take account of config changes (usually changes to user 
accounts.) When I do this, the following occurs:

A: nfs shares which are unmounted become unavailable (cd-ing to the 
directory results in a 'no such file or directory' error)

B: nfs shares which are mounted report stale file handles.

I can understand where problem A comes from - and I figure restarting 
autofs would clear that, but it is not really practical to do on each 
machine. But I'm not sure why B should happen...?

Dylan
-- 
Sweet moderation
Heart of this nation
Desert us not
We are between the wars
- Billy Bragg
