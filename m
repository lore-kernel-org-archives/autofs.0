From: Mike Seda <maseda@unc.edu>
Subject: uninitialized value in hash element
Date: Fri, 07 Apr 2006 09:59:18 -0400
Message-ID: <44367036.2000701@unc.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi All,
The following is the entire automount section of a LogWatch email for 
one of my servers:

 --------------------- Automount Begin ------------------------

Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 2.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 2.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 5.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 8.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 11.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 14.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 17.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 20.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 23.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 26.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 29.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 32.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 35.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 38.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 41.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 44.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 47.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 50.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 53.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 56.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 59.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 62.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 65.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 68.
Use of uninitialized value in hash element at 
/etc/log.d/scripts/services/automount line 28, <STDIN> line 71.

Failed mounts:
          NFS Mount Failure 24 Time(s)

**Unmatched Entries**
failed to mount /home/bpuser: 11 Time(s)
failed to mount /home/ls: 8 Time(s)
failed to mount /home/df: 5 Time(s)

 ---------------------- Automount End -------------------------

Does anyone know what could cause the hash element errors? I looked in 
/var/log/messages, and this error also appeared previously when trying 
to mount /home/gateway, which doesn't even exist on my system. Btw, 
/home/ls and /home/df do not exist either, but /home/bpuser does. I 
never executed mount requests for either /home/gateway, /home/ls, or 
/home/df, and there is a slim chance that any of my users did. I have 
seen these errors on other machines running the same kernel and 
automount version, and it is really bugging me. Any thoughts would be 
much appreciated.
Regards,
maseda
