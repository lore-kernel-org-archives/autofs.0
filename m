From: Stef Bon <stef@bononline.nl>
Subject: Testing a key is mounted.
Date: Sun, 7 Mar 2010 20:19:58 +0100
Message-ID: <201003072019.58672.stef@bononline.nl>
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

Hi,

some time ago I asked here it is possible to test a valid key is mounted, in a 
autofs managed directory.

I've written a function which does that for me, from within a FUSE module. SO 
now it's not necessary anymore to do this via autofs. THis does not mean for 
me that communicating with a automount process via /dev/autofs is not a good 
thing.

My function:


static signed int Md5KeyIsMounted(const char *testmd5key)
{
int nreturn=-1;
DIR *dp;
struct dirent *de;

// only check when this directory is an option

syslog(MY_LOG, "Md5KeyIsMounted, key: %s", testmd5key);

if ( strlen(testmd5key) != MD5_DIR_LEN ) goto out;

if ( options.autofs_mount_path != NULL ) {

    dp = opendir(options.autofs_mount_path);

    if (dp == NULL) goto out;

    while ((de = readdir(dp)) != NULL) {


        syslog(MY_LOG, "md5key found: %s", de->d_name);

        if ( strcmp(de->d_name,testmd5key) == 0 ) {

            nreturn=1;
            goto out;
            }
        }

    closedir(dp);


    }

out:

return nreturn;
}
It just looks at the directory where autofs creates the autofs managed (key) 
directories. If mounted it exists.

Now when in my fs there is a lookup of a .directory file, which is in a autofs 
managed directory, it's able to determine it's mounted or not, and depending 
on the result of that test, present a different .directory.

Note that my fuse fs intercept calls to this .directory file and present 
.directory file from a predefined place. If t does not do that, it will just 
try to look at the .directory file in the autofs managed mount point, causing 
it to be mounted.

Stef
