From: Giovanni Romanenghi <giovanni.romanenghi@sorint.it>
Subject: AutoFS problem
Date: Wed, 26 May 2004 17:07:21 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <5a3315fad7.5fad75a331@sorint.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Ci0YAE9JMQu5DP/sqbv0/Q)"
Return-path: <autofs-bounces@linux.kernel.org>
Content-language: it
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Ci0YAE9JMQu5DP/sqbv0/Q)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

I configure my sun java desktop to authenticate with ldap server ( Sun Java System Directory server 5.1 Sp3) and I configure autofs to mount user home directory at logon and it works .

My problem is that the clients don't mount other file systems that aren't home directory.

All file systems that the workstation must mount are configured on ldap server.

When I connect from my workstation with my user giovanni , I view my home directory but the autofs doesn't mount the disk /u and /prova.

The nfs server is ok because i can mount all share from my workstation manually.
My /etc/exports:
/tmp/tmp (rw,sync,no_root_squash)
/tmp/u (rw,sync,no_root_squash)
/var/prova (rw,sync,no_root_squash)

/etc/init.d/autofs status:
Configured Mount Points:
------------------------
/usr/sbin/automount /u ldap ldap.:.it:ou=auto.u,o=test.it,dc=test,dc=it
/usr/sbin/automount /home ldap ldap.test.it:ou=auto.home,o=test.it,dc=test,dc=it
/usr/sbin/automount /prova ldap ldap.test.it:ou=auto.prova,o=test.it,dc=test,dc=it

Active Mount Points:
--------------------
/usr/sbin/automount /u ldap ldap.test.it:ou=auto.u,o=test.it,dc=test,dc=it
/usr/sbin/automount /home ldap ldap.test.it:ou=auto.home,o=test.it,dc=test,dc=it
/usr/sbin/automount /prova ldap ldap.test.it:ou=auto.prova,o=test.it,dc=test,dc=it


This is my df -k:
/dev/hda1 10490084 5951992 4538092 57% /
/dev/hda4 5694860 4495668 1199192 79% /backup
shmfs 127868 0 127868 0% /dev/shm
/tmp/tmp/giovanni 10490084 5951992 4538092 57% /home/giovanni


I install this version of autofs:
autofs-3.1.7-731

Any Ideas?
TIA
Giovanni

P.S. I attach the export of LDAP. 

--Boundary_(ID_Ci0YAE9JMQu5DP/sqbv0/Q)
Content-type: application/octet-stream; NAME=master.ldif
Content-transfer-encoding: base64
Content-disposition: attachment; filename=master.ldif

ZG46IG91PWF1dG8ubWFzdGVyLCBvPXRlc3QuaXQsIGRjPXRlc3QsZGM9aXQKb3U6IGF1dG8u
bWFzdGVyCm9iamVjdENsYXNzOiB0b3AKb2JqZWN0Q2xhc3M6IGF1dG9tb3VudE1hcAoKZG46
IGNuPS91LCBvdT1hdXRvLm1hc3Rlciwgbz10ZXN0Lml0LCBkYz10ZXN0LGRjPWl0Cm9iamVj
dENsYXNzOiBhdXRvbW91bnQKb2JqZWN0Q2xhc3M6IHRvcAphdXRvbW91bnRJbmZvcm1hdGlv
bjogbGRhcCBsZGFwLnRlc3QuaXQ6b3U9YXV0by51LG89dGVzdC5pdCxkYz10ZXN0LGRjPWl0
CmNuOiAvdQoKZG46IGNuPS9ob21lLCBvdT1hdXRvLm1hc3Rlciwgbz10ZXN0Lml0LCBkYz10
ZXN0LGRjPWl0Cm9iamVjdENsYXNzOiBhdXRvbW91bnQKb2JqZWN0Q2xhc3M6IHRvcAphdXRv
bW91bnRJbmZvcm1hdGlvbjogbGRhcCBsZGFwLnRlc3QuaXQ6b3U9YXV0by5ob21lLG89dGVz
dC5pdCxkYz10ZXN0LGRjPWl0CmNuOiAvaG9tZQoKZG46IGNuPS9wcm92YSwgb3U9YXV0by5t
YXN0ZXIsIG89dGVzdC5pdCwgZGM9dGVzdCxkYz1pdApvYmplY3RDbGFzczogYXV0b21vdW50
Cm9iamVjdENsYXNzOiB0b3AKYXV0b21vdW50SW5mb3JtYXRpb246IGxkYXAgbGRhcC50ZXN0
Lml0Om91PWF1dG8ucHJvdmEsbz10ZXN0Lml0LGRjPXRlc3QsZGM9aXQKY246IC9wcm92YQoK
ZG46IG91PWF1dG8uaG9tZSwgbz10ZXN0Lml0LCBkYz10ZXN0LGRjPWl0Cm91OiBhdXRvLmhv
bWUKb2JqZWN0Q2xhc3M6IHRvcApvYmplY3RDbGFzczogYXV0b21vdW50TWFwCgpkbjogY249
Z2lvdmFubmksIG91PWF1dG8uaG9tZSwgbz10ZXN0Lml0LCBkYz10ZXN0LGRjPWl0Cm9iamVj
dENsYXNzOiBhdXRvbW91bnQKb2JqZWN0Q2xhc3M6IHRvcAphdXRvbW91bnRJbmZvcm1hdGlv
bjogLWZzdHlwZT1uZnMsaGFyZCxpbnRyIDE5Mi4xNjguMS4xNjI6L3RtcC90bXAvZ2lvdmFu
bmkKY246IGdpb3Zhbm5pCgpkbjogb3U9YXV0by5wcm92YSwgbz10ZXN0Lml0LCBkYz10ZXN0
LGRjPWl0Cm91OiBhdXRvLnByb3ZhCm9iamVjdENsYXNzOiB0b3AKb2JqZWN0Q2xhc3M6IGF1
dG9tb3VudE1hcAoKZG46IGNuPWdpb3Zhbm5pLCBvdT1hdXRvLnByb3ZhLCBvPXRlc3QuaXQs
IGRjPXRlc3QsZGM9aXQKb2JqZWN0Q2xhc3M6IGF1dG9tb3VudApvYmplY3RDbGFzczogdG9w
CmF1dG9tb3VudEluZm9ybWF0aW9uOiAtZnN0eXBlPWF1dG9mcyxoYXJkLGludHIgMTkyLjE2
OC4xLjE2MjovdmFyL3Byb3ZhCmNuOiBnaW92YW5uaQoKZG46IG91PWF1dG8udSwgbz10ZXN0
Lml0LCBkYz10ZXN0LGRjPWl0Cm91OiBhdXRvLnUKb2JqZWN0Q2xhc3M6IHRvcApvYmplY3RD
bGFzczogYXV0b21vdW50TWFwCgpkbjogY249Z2lvdmFubmksIG91PWF1dG8udSwgbz10ZXN0
Lml0LCBkYz10ZXN0LGRjPWl0Cm9iamVjdENsYXNzOiBhdXRvbW91bnQKb2JqZWN0Q2xhc3M6
IHRvcAphdXRvbW91bnRJbmZvcm1hdGlvbjogLWZzdHlwZT1uZnMsaGFyZCxpbnRyIDE5Mi4x
NjguMS4xNjI6L3RtcC91CmNuOiBnaW92YW5uaQoK

--Boundary_(ID_Ci0YAE9JMQu5DP/sqbv0/Q)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary_(ID_Ci0YAE9JMQu5DP/sqbv0/Q)--

