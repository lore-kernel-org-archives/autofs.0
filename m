From: "MARX,ALEXANDER (HP-Germany,ex1)" <alexander.marx@hp.com>
Subject: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 15:26:52 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <F3123864FB69D411946000D0B77FBBDF0D5E13EF@haendel.bbn.hp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi list,

autofs (v4,3.1.7-425) is too intelligent ... 

Directory 'test' is exported via the nfs server on host 'foo' and imported
again via the linux automounter locally as soon as 'test' is accessed
(corresponding entry in automounter map). The automounter recognizes that
'test' is a local directory and performs a bind mount. 

Great feature - BUT, there is no way to turn off this functionality. I would
need to always have nfs mounts regardless of having the exported directory
locally or remotely.

In some scenarios (e.g. HA), the nfs server could switch from local to
remote, therefore having local binds is not a desirable scenario, there
should always be nfs mounts.

Is there some kind of workaround or possibiliy to perform such actions, or
will the automounter always be smarter that me :-) ?

Thanks,

Alex

-
Alexander Marx
