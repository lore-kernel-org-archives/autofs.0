From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Negative caching of failed mount attempts
Date: Thu, 16 Apr 2009 17:39:03 -0300
Message-ID: <c2d0b6ec0904161339j3573f25em3b6a1ac1168fa032@mail.gmail.com>
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

Three years ago, commit 2d753e62b8 removed kernel-side caching
of mount attempts that returns -ENOENT. Apparently it wasn't
working as it should.
I see that this feature is now implemented in the user land AutoFS 5
daemon, but it wasn't back ported to AutoFS 4. I understand that
version 4 is not maintained anymore, but I'd like to ask if someone
has a patch around that implements this feature.

Thanks,
Leonardo
