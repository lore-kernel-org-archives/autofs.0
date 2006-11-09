From: Dana Wellen <dana.wellen@onsemi.com>
Subject: Problem patching kernel in Rhel-4
Date: Thu, 09 Nov 2006 12:10:21 -0500
Message-ID: <455360FD.50205@onsemi.com>
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

Hello,

  I am really glad to see that autofs is finally being updated to one 
that works in a multi-OS environment.  Autofs
has long been a weak link into the standard Unix environment and this 
version fixes many of the issues I have had
with v4 and getting the company to switch to Linux because Linux wasn't 
plug and play with the Solaris automounter.

  I am getting a error patching the kernel in Rhel-4.

The kernel being used is 2.6.9-5.ELsmp, I have installed the 
corresponding source rpm and unpacked the kernel.

A transcript of the error is:

patching file fs/namei.c
Hunk #4 FAILED at 635.
Hunk #5 succeeded at 752 (offset 6 lines).
1 out of 6 hunks FAILED -- saving rejects to file fs/namei.c.rej

All of the other files used in the patch are patched correctly.  The 
namei.c file is the only one
that doesn't patch. 

  This is the error file made by patch.

cat namei.c.rej
***************
*** 654,665 ****
        goto done;

  need_revalidate:
-       dentry = do_revalidate(dentry, nd);
-       if (!dentry)
-               goto need_lookup;
-       if (IS_ERR(dentry))
-               goto fail;
-       goto done;

  fail:
        return PTR_ERR(dentry);
--- 635,646 ----
        goto done;

  need_revalidate:
+       if (dentry->d_op->d_revalidate(dentry, nd))
+               goto done;
+       if (d_invalidate(dentry))
+               goto done;
+       dput(dentry);
+       goto need_lookup;

  fail:
        return PTR_ERR(dentry);


 Also, I couldn't find any information on what the flock patches are for 
in the documentation.

  I have been able to build the kernel and autofs using Suse 10.1 and 
Sled 10 but not Rhel-4.


-- 
