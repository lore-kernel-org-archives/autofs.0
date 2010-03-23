From: Stef Bon <stef@bononline.nl>
Subject: About listing to /dev/autofs
Date: Tue, 23 Mar 2010 12:23:17 +0100
Message-ID: <201003231223.17161.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hello,

I've written a small app, which listens to the device /dev/autofs, to read 
what kind of messages come from it.

Starting the automounter, with USE_MISC_DEVICE set to yes.

A small app, (copied from the fuse source..):

#include <sys/select.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>


int main(void)
{
        int fds;
        int nfds;

        fds = open("/dev/autofs", O_RDONLY);
        nfds = 2;

        while (1) {
                static char buf[4096];
                fd_set rfds;
                int rc;

                FD_ZERO(&rfds);

                FD_SET(fds, &rfds);

                rc = select(nfds, &rfds, NULL, NULL, NULL);

                if (rc < 0) {
                        perror("select");
                        return 1;
                }

                if (!FD_ISSET(fds, &rfds)) {
                                printf("_:   ");
                } else {

                    rc = read(fds, buf, sizeof(buf));

                    if (rc < 0) {
                        perror("read");
                        return 1;
                    }

                    printf("%02d ", rc);
                    
                }
                printf("\n");
        }
}


After compiling and starting it as normal user (and setting the properties of 
/dev/autofs to 666), I do not get any output. I expect some messages, like 
mounted directory...

Can somebody explain this??

Stef Bon
