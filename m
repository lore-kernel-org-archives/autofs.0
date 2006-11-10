From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: autofsv5 - mouting files (not dirs)
Date: Fri, 10 Nov 2006 17:33:40 +0000
Message-ID: <4554B7F4.3050909@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
	<45546B1F.5030306@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45546B1F.5030306@ggr.co.uk>
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

    The automount code (at least for indirect mounts) will not mount an 
entry which is a file - it has to be a directory.

    The reason behind this is that the code first creates the directory 
then tries to mount the remote object on it.

    In order to mount a remote file you need to mount it over a file, 
not a directory.  (As far as I can tell, mounting a file on a file works 
OK in Linux).

    Would it be possible to get automount to retry on a file if it gets 
ENOTDIR from the remote end?
